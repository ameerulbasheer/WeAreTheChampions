//
//  TestCases.swift
//  WeAreTheChampions
//
//  Created by Ameerul Basheer on 8/7/22.
//

import Foundation

let testCasesTeams = [testCase01Teams, testCase02Teams, testCase03Teams]
let testCasesMatches = [testCase01Matches, testCase02Matches, testCase03Matches]

//Test case #1:
//Team information:
let testCase01Teams = """
teamA 01/04 1
teamB 02/05 1
teamC 03/06 1
teamD 04/06 1
teamE 05/06 1
teamF 15/06 1
teamG 14/06 2
teamH 13/06 2
teamI 12/06 2
teamJ 11/06 2
teamK 10/06 2
teamL 27/06 2
"""

//Match results:
let testCase01Matches = """
teamA teamB 0 1
teamA teamC 1 3
teamA teamD 2 2
teamA teamE 2 4
teamA teamF 3 3
teamB teamC 0 1
teamB teamD 2 2
teamB teamE 4 0
teamB teamF 0 0
teamC teamD 2 0
teamC teamE 0 0
teamC teamF 1 0
teamD teamE 0 3
teamD teamF 2 1
teamE teamF 3 4
teamG teamH 3 2
teamG teamI 0 4
teamG teamJ 1 0
teamG teamK 1 4
teamG teamL 1 4
teamH teamI 2 0
teamH teamJ 3 0
teamH teamK 3 4
teamH teamL 0 1
teamI teamJ 2 1
teamI teamK 3 0
teamI teamL 1 3
teamJ teamK 1 4
teamJ teamL 0 3
teamK teamL 0 0
"""

//Test case #2:
//Team information:
let testCase02Teams = """
teamA 01/04 1
teamB 02/05 2
teamC 03/06 1
teamD 04/06 2
teamE 05/06 2
teamF 15/06 1
teamG 14/06 2
teamH 13/06 1
teamI 12/06 1
teamJ 11/06 2
teamK 10/06 1
teamL 27/06 2
"""
//Match results:
let testCase02Matches = """
teamA teamC 3 4
teamA teamF 1 1
teamA teamH 2 1
teamA teamI 0 2
teamA teamK 1 0
teamB teamD 2 2
teamB teamE 2 1
teamB teamG 1 2
teamB teamJ 1 4
teamB teamL 1 1
teamC teamF 1 3
teamC teamH 2 2
teamC teamI 4 1
teamC teamK 0 2
teamD teamE 3 0
teamD teamG 4 1
teamD teamJ 4 4
teamD teamL 4 1
teamE teamG 3 4
teamE teamJ 0 1
teamE teamL 1 0
teamF teamH 2 4
teamF teamI 2 1
teamF teamK 3 3
teamG teamJ 3 1
teamG teamL 2 1
teamH teamI 1 1
teamH teamK 0 1
teamI teamK 4 1
teamJ teamL 2 1
"""
//Test case #3:
//Team information:
let testCase03Teams = """
teamA 01/04 1
teamB 02/05 2
teamC 03/06 1
teamD 04/06 2
teamE 05/06 2
teamF 15/06 1
teamG 14/06 2
teamH 13/06 1
teamI 12/06 1
teamJ 11/06 2
teamK 10/06 1
teamL 27/06 2
"""

//Match results:
let testCase03Matches = """
teamA teamC 3 3
teamA teamF 4 4
teamA teamH 1 1
teamA teamI 3 3
teamA teamK 0 0
teamB teamD 2 1
teamB teamE 3 2
teamB teamG 8 8
teamB teamJ 1 3
teamB teamL 0 0
teamC teamF 3 1
teamC teamH 1 3
teamC teamI 3 3
teamC teamK 1 3
teamD teamE 1 2
teamD teamG 2 1
teamD teamJ 1 4
teamD teamL 4 4
teamE teamG 0 2
teamE teamJ 4 3
teamE teamL 2 2
teamF teamH 1 3
teamF teamI 2 4
teamF teamK 3 4
teamG teamJ 0 2
teamG teamL 3 3
teamH teamI 0 0
teamH teamK 3 2
teamI teamK 0 3
teamJ teamL 4 4
"""
