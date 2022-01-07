class DriveGeometryError(Exception):
    pass

def LBA_from_CHS(C, H, S, HPC, SPT):
    if S < 1:
        print("S must be >=1")
        raise DriveGeometryError
    if S > SPT:
        print("S must be <= SPT")
        raise DriveGeometryError
    if H >= HPC:
        print("H must be < HPC")
        raise DriveGeometryError
    return ( C * HPC + H ) * SPT + ( S - 1 )


def CHS_from_LBA(LBA, HPC, SPT):
    C = LBA // ( HPC * SPT )
    H = ( LBA // SPT ) % HPC
    S = ( LBA % SPT ) + 1
    return (C, H, S)

