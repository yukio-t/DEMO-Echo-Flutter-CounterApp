package memory

import "sync"

// CounterStore は clientId 単位でカウンター値を保持するインメモリストア。
// 同一 clientId に対する更新は client ごとの mutex による排他制御で直列化される。
// ※プロセス再起動で状態は失われる（仕様）。
type CounterStore struct {
	mu      sync.Mutex
	clients map[string]*clientState
}

type clientState struct {
	mu    sync.Mutex
	value int
}

func NewCounterStore() *CounterStore {
	return &CounterStore{
		clients: make(map[string]*clientState),
	}
}

func (s *CounterStore) getOrCreate(clientID string) *clientState {
	s.mu.Lock()
	defer s.mu.Unlock()

	if st, ok := s.clients[clientID]; ok {
		return st
	}

	st := &clientState{value: 0}
	s.clients[clientID] = st
	return st
}

// Get returns current value (serialized per client).
func (s *CounterStore) Get(clientID string) int {
	st := s.getOrCreate(clientID)
	st.mu.Lock()
	defer st.mu.Unlock()
	return st.value
}

// Increment increments and returns new value (serialized per client).
func (s *CounterStore) Increment(clientID string) int {
	st := s.getOrCreate(clientID)
	st.mu.Lock()
	defer st.mu.Unlock()
	st.value++
	return st.value
}

// Reset sets value to 0 and returns new value (serialized per client).
func (s *CounterStore) Reset(clientID string) int {
	st := s.getOrCreate(clientID)
	st.mu.Lock()
	defer st.mu.Unlock()
	st.value = 0
	return st.value
}
