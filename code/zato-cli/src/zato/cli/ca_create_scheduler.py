# -*- coding: utf-8 -*-

"""
Copyright (C) 2019, Zato Source s.r.o. https://zato.io

Licensed under LGPLv3, see LICENSE.txt for terms and conditions.
"""

from __future__ import absolute_import, division, print_function, unicode_literals

# Zato
from zato.cli import CACreateCommand, common_ca_create_opts

class Create(CACreateCommand):
    """ Creates crypto material for a Zato scheduler.
    """
    opts = [
        {'name':'cluster_name', 'help':'Cluster name'},
        {'name':'scheduler_name', 'help':'Scheduler name'},
        {'name':'--organizational-unit', 'help':'Organizational unit name (defaults to cluster_name:scheduler_name)'},
    ]
    opts += common_ca_create_opts

    def get_file_prefix(self, file_args):
        return '{cluster_name}-{scheduler_name}'.format(**file_args)

    def get_organizational_unit(self, args):
        return args.cluster_name + ':' + args.scheduler_name

    def execute(self, args, show_output=True):
        self._execute(args, 'v3_client_server', show_output)
