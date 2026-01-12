package counter

// Store は usecase から見たカウンターストア抽象。
// infra/memory の実装はこの interface を満たせばよい。
type Store interface {
	Get(clientID string) int
	Increment(clientID string) int
	Reset(clientID string) int
}

type Service struct {
	store Store
}

func NewService(store Store) *Service {
	return &Service{store: store}
}

func (s *Service) Get(clientID string) (int, error) {
	// 要件上、clientID がミドルウェアで保証される想定
	return s.store.Get(clientID), nil
}

func (s *Service) Increment(clientID string) (int, error) {
	return s.store.Increment(clientID), nil
}

func (s *Service) Reset(clientID string) (int, error) {
	return s.store.Reset(clientID), nil
}
