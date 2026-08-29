# Kubernetes Common Errors

## ImagePullBackOff / ErrImagePull
**Cause**: Kubernetes cannot pull the container image.
**Fix**: 
- Check if the image name/tag has a typo.
- Check if the image exists in the registry.
- Check if the registry requires authentication (ImagePullSecrets).

## CrashLoopBackOff
**Cause**: The container starts, but crashes immediately, and Kubernetes keeps restarting it.
**Fix**:
- Check `kubectl logs <pod> --previous`.
- Verify the container's entrypoint/command.
- Ensure environment variables and configs are correctly mounted and formatted.

## CreateContainerConfigError
**Cause**: Missing ConfigMap or Secret that the Pod depends on.
**Fix**:
- Check `kubectl describe pod <pod>`. It will tell you which ConfigMap or Secret is missing.
- Create the missing resource or fix the typo in the Pod manifest.

## OOMKilled
**Cause**: Container exceeded its memory limit.
**Fix**:
- Increase the memory limit in the deployment manifest.
- Profile the application to find memory leaks.
