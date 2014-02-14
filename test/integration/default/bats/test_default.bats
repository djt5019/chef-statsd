@test "should create the daemon user" {
    getent passwd statsd
}

@test "should be running statsd" {
    pgrep statsd
}

@test "should verify statsd is healthy" {
    test "$(echo 'health' | nc 0.0.0.0 8126)" = 'health: up'
}
