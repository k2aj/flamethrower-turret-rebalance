PACKAGE_NAME=flamethrower-turret-rebalance.zip

package: clean
	zip -r $(PACKAGE_NAME) flamethrower-turret-rebalance LICENSE

clean:
	rm -f $(PACKAGE_NAME)