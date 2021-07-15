# Coolify

Install coolify self hosted heroku alternative

### Roadmap

- [ ] Create full github app with api
- [ ] Use ansible Swarm collection
- [ ] Mongo replicas

## Install to requirements.yml

```
- src: git+git@github.com:loic-roux-404/role-coolify
  version: master
```

## Requirements

None

## Role Variables

- Check [defaults.yml](./defaults/main.yml)

## Dependencies

None

## Example Playbook

```yaml
- hosts: servers
  roles:
    - { role: role-coolify }
```

## License

MIT

## Author Information

[Loic Roux](github.com/loic-roux-404)
