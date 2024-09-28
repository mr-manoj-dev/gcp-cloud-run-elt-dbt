from flask import Flask
import os
import subprocess
import logging

app = Flask(__name__)


@app.route('/health', methods=['GET'])
def hello_world():
    return 'I am running fine. Thanks!'


@app.route('/invoke', methods=['GET'])
def handler():
    try:
        # Execute the shell script
        # subprocess.run(['run_dbt.sh'], check=True, cwd='/dbt')
        script_path = os.path.abspath('/dbt/run_dbt.sh')
        # Verify the script path
        if not os.path.isfile(script_path):
            logging.error(f"Script not found at: {script_path}")
            return f"Script not found at: {script_path}", 404

        result = subprocess.run(f"bash {script_path}", shell=True, check=True)
        if result.returncode == 0:
            logging.info(f"DBT ran with return code: {str(result.returncode)}")
            return "Script executed successfully", 200
    except subprocess.CalledProcessError as e:
        logging.error(f"An error occurred: {e}")
        return f"An error occurred: {e}", 500


if __name__ == '__main__':
    port = int(os.environ.get("PORT", 8080))
    app.run(debug=True, host='0.0.0.0', port=port)
