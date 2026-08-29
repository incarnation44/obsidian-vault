import subprocess
import sys
import json

def run_cmd(cmd):
    try:
        result = subprocess.run(cmd, shell=True, check=True, capture_output=True, text=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        return f"Error: {e.stderr.strip()}"

def main():
    namespace = sys.argv[1] if len(sys.argv) > 1 else "default"
    print(f"=== KUBERNETES TRIAGE REPORT (Namespace: {namespace}) ===")
    
    print("\n[1] Failing Pods:")
    pods_cmd = f"kubectl get pods -n {namespace} --field-selector=status.phase!=Running -o json"
    pods_out = run_cmd(pods_cmd)
    
    try:
        pods_json = json.loads(pods_out)
        if not pods_json.get("items"):
            print("No failing pods found in this namespace.")
        else:
            for pod in pods_json["items"]:
                name = pod["metadata"]["name"]
                status = pod["status"]["phase"]
                reason = pod["status"].get("reason", "N/A")
                print(f" - {name} | Status: {status} | Reason: {reason}")
    except json.JSONDecodeError:
        print(pods_out)

    print("\n[2] Recent Warning Events (Last 10):")
    events_cmd = f"kubectl get events -n {namespace} --field-selector type=Warning --sort-by='.metadata.creationTimestamp' -o custom-columns=TIME:.lastTimestamp,NAME:.involvedObject.name,REASON:.reason,MESSAGE:.message | tail -n 10"
    print(run_cmd(events_cmd))

if __name__ == "__main__":
    main()
