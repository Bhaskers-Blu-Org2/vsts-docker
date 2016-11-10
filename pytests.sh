#!/bin/bash
set -e

cat << EOF > r.sh
{
    #!/bin/bash
    set -e
    python -m pip install requests pyyaml mock paramiko sshtunnel coverage
    coverage run --source=src/tasks/dockerDeploy/acs-dcos -m unittest discover -s src/tasks/dockerDeploy/acs-dcos
    coverage report -m
}
EOF
chmod +x r.sh 
docker run --rm -v "$PWD":/tests -w /tests python:2.7 /bin/bash -c /tests/r.sh
exit $?