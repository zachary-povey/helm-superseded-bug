# helm-superseded-bug

Demo of a helm bug where failed versions are marked as superseded.

Two cases are demonstrated (**WARN** scripts will deploy a CRD to whichever k8 env your kubectl is configured for):

## Case 1

Case where initial installation fails, the subesequent sucessful deployment causes the inital failed version to be marked as "superseded".

Run `demo_2.sh` to see this played out on your k8 cluster.

## Case 2

Case where we have a sucessful deployment followed by a failure, when we try to rollback to the sucessful deployment it fails (a separate related issue, see https://github.com/helm/helm/issues/10219) even though it fails the previous release, which also failed, is marked as superseded.

Run `demo_2.sh` to see this played out on your k8 cluster.

## Cleanup

The scripts don't cleanup at the end of execution to leave state for you to have a look at, run `cleanup.sh` to remove the helm deployment and delte the namespace.
