echo "starting pytest testing"
echo "creating virtual environment and installing dependencies"
python -V
python -m venv env
source env/bin/activate
echo "virtual environment created and activated"
echo "installing dependencies from requirements.txt"
pip install -r requirements.txt
echo "dependencies installed"
cd android
echo "running pytest for bstack-sample-test.py"
rm -rf log logs && browserstack-sdk pytest ./bstack_sample.py -s
echo "pytest testing completed"
deactivate -s
rm -rf env
