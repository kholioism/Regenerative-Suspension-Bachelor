#ifndef OrganizedModel_h_
#define OrganizedModel_h_
#ifndef OrganizedModel_COMMON_INCLUDES_
#define OrganizedModel_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging_simtarget.h"
#include "rt_nonfinite.h"
#include "math.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "OrganizedModel_types.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include <string.h>
#define MODEL_NAME OrganizedModel
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (22) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (6)   
#elif NCSTATES != 6
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T aejv0x152k ; real_T dslgo4omgy ; real_T cvjc12g5qg ;
real_T gjwy40byd3 ; real_T pvchdyldri ; real_T d40k2li224 ; real_T dn0ba1tjc2
; real_T fhxinutrfw ; real_T pc0wowoobk ; real_T o4cn4xslkk ; real_T
iofima4jnn ; real_T e3pou1i4xo ; real_T jab110azsl ; real_T bqikihvpx3 ;
real_T gthnrci0t0 ; real_T dy0k2atnsj ; real_T moxyj1crfh ; real_T haryu314ub
; real_T fay3pdrgdl ; real_T etbilfl5to ; uint8_T fkykcmo4z4 ; } B ; typedef
struct { struct { void * LoggedData ; } cbkxhxsi21 ; struct { void *
LoggedData ; } l3bw21k2lp ; struct { void * LoggedData ; } opsfd12nq2 ;
struct { void * LoggedData [ 3 ] ; } dozf2wqn0h ; struct { void * LoggedData
[ 2 ] ; } eagfkzrtcr ; struct { void * LoggedData ; } bz4gy522lh ; struct {
void * LoggedData [ 2 ] ; } hniuztbprt ; struct { void * LoggedData [ 3 ] ; }
acfbgsqbwh ; struct { void * LoggedData [ 3 ] ; } hyrqlehufe ; int32_T
bdh2podgin ; int32_T ojgi13rvoo ; int32_T lusjoacyj3 ; boolean_T lpxqmn4h3y ;
boolean_T ep1iwe1lkb ; boolean_T pc3nqj2mvk ; } DW ; typedef struct { real_T
muebl4vcxa ; real_T pwqrqa2o0k ; real_T l0v3qsjjvs ; real_T jjqadzq4vf ;
real_T eky0u2ohw4 ; real_T omjcephhls ; } X ; typedef struct { real_T
muebl4vcxa ; real_T pwqrqa2o0k ; real_T l0v3qsjjvs ; real_T jjqadzq4vf ;
real_T eky0u2ohw4 ; real_T omjcephhls ; } XDot ; typedef struct { boolean_T
muebl4vcxa ; boolean_T pwqrqa2o0k ; boolean_T l0v3qsjjvs ; boolean_T
jjqadzq4vf ; boolean_T eky0u2ohw4 ; boolean_T omjcephhls ; } XDis ; typedef
struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct P_ { real_T Er
; real_T L ; real_T L_DC ; real_T R ; real_T Rv ; real_T cb ; real_T cc ;
real_T cg ; real_T cs ; real_T kb ; real_T ke ; real_T ki ; real_T ks ;
real_T kt ; real_T ms ; real_T mu ; real_T vd ; real_T
CompareToConstant_const ; real_T Integrator4_IC ; real_T Integrator_IC ;
real_T Integrator1_IC ; real_T Gain7_Gain ; real_T Integrator5_IC ; real_T
SineWave_Amp ; real_T SineWave_Bias ; real_T SineWave_Freq ; real_T
SineWave_Phase ; real_T Integrator2_IC ; real_T Integrator3_IC ; real_T
Saturation1_UpperSat ; real_T Saturation1_LowerSat ; real_T
Saturation_UpperSat ; real_T Saturation_LowerSat ; real_T Constant3_Value ; }
; extern const char_T * RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X
rtX ; extern DW rtDW ; extern P rtP ; extern mxArray *
mr_OrganizedModel_GetDWork ( ) ; extern void mr_OrganizedModel_SetDWork ( const
mxArray * ssDW ) ; extern mxArray *
mr_OrganizedModel_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * OrganizedModel_GetCAPIStaticMap ( void ) ;
extern SimStruct * const rtS ; extern DataMapInfo * rt_dataMapInfoPtr ;
extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs ( int_T
tid ) ; void MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) ;
#endif
