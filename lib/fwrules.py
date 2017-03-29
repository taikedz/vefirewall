import os
import fwcall

class FirewallRuleset:
    rules = None
    policies = None

    def __init__(self, filepath):
        pass
        # read rule file
        # extract policies and rules

    def applyRules(self):
        pass

    def applyPolicies(self):
        pass

class FirewallManager:
    def __init__(self):
        pass

    def flush(self, chains):
        """ chains: array of table -> chain that should be opened and flushed
        """
        pass

