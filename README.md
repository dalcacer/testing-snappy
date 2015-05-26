Simple setup to test snappy based on [this tutorial](http://developer.ubuntu.com/en/snappy/tutorials/using-snappy/).

# Contains

Vagrant description for ubuntu core VM.

# Usage

* `vagrant up`
* in terminal
	* `scp -P 2222 test-bandwidth.sh ubuntu@localhost:~/`
	* `scp -P 2222 test-packageloss.sh ubuntu@localhost:~/`
	* `scp -P 2222 reduce-bandwidth.sh ubuntu@localhost:~/`
* in gui
	* `sudo ./test-bandwidth && sudo ./test-packageloss`
* pull data
	* `scp -P 2222 ubuntu@localhost:~/snappy-bandwidth.txt .`
	* `scp -P 2222 ubuntu@localhost:~/snappy-packageloss.txt .`