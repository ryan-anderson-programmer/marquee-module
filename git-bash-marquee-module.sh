#! /usr/bin/env/ bash

##################################################################################
#                                                                                #
#    Copyright 2023 Ryan E. Anderson                                             #
#                                                                                #
#    Licensed under the Apache License, Version 2.0 (the "License");             #
#    you may not use this file except in compliance with the License.            #
#    You may obtain a copy of the License at                                     #
#                                                                                #
#        http://www.apache.org/licenses/LICENSE-2.0                              #
#                                                                                #
#    Unless required by applicable law or agreed to in writing, software         #
#    distributed under the License is distributed on an "AS IS" BASIS,           #
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    #
#    See the License for the specific language governing permissions and         #
#    limitations under the License.                                              #
#                                                                                #
##################################################################################

################################################
#                                              #
#    MarqueeModule v0.1.0 Git Bash Launcher    #
#                                              #
#    By Ryan E. Anderson                       # 
#                                              #
#    Copyright (C) 2023 Ryan E. Anderson       #
#                                              #
################################################

if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "A Git repository has been initialized at this location ($(pwd))."
else
    echo "A Git repository has not been initialized at this location ($(pwd))."
fi;

read -p 'Press any key to continue launching Git Bash...'

(cd . && start sh --login)