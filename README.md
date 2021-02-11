# kubernetes-helm-chart-pgbouncer

This project is a [Helm](https://helm.sh/) chart implementation for [PgBouncer](https://pgbouncer.github.io).

---

### Configuration
Create a values.override.yaml (or similar) to add your *databases* and *users* settings.

```yaml
# values.override.yaml example
replicaCount: 1
verbose: 1
users:
  dbuser: notagoodpassword
databases:
  postgres:
    host: postgresql-internal
    port: 5432
    user: dbuser
    dbname: postgres
connectionLimits:
  defaultPoolSize: 20
  minPoolSize: 20
  reservePoolSize: 20
```

---
### Installation

```bash
helm install -f values.override.yaml pgbouncer
```

or in your chart's requirements.yaml

```
dependencies:
- name: pgbouncer
  version: 1.0.11
  repository: https://raw.githubusercontent.com/cradlepoint/kubernetes-helm-chart-pgbouncer/master/repos/stable
```
