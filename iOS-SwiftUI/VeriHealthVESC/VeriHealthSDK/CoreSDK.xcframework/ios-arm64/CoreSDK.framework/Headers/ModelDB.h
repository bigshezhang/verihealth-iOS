//
//  ModelDB.h
//  CoreSDK
//
//  Created by Kaili Lu on 2021/9/17.
//

#ifndef ModelDB_h
#define ModelDB_h

/** @addtogroup DataModel
 *  Definition of database models for various vital signs, alerts, etc.
 *  @ingroup DataDefine
 *  @{
 */

#import <Realm/Realm.h>

@class Model;

@interface UserModel : RLMObject
@property NSString *userName;
@property NSString *deviceName;
@property NSString *uuid;
@property int version;
@end

/**
 * @brief Heart Rate (HR) DataModel
 */
@interface HRModel : RLMObject
@property int timeStamp; /**< Timestamp when heart rate value was generated*/
@property int value; /**< Heart rate value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Respiratory Rate (RR) DataModel
 */
@interface RRModel : RLMObject
@property int timeStamp; /**< Timestamp when respiratory rate value was generated*/
@property int value; /**< Respiratory rate value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief SpO2 DataModel
 */
@interface Spo2Model : RLMObject
@property int timeStamp; /**< Timestamp when SpO2 value was generated*/
@property int value; /**< SpO2 value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief StepCount DataModel
 */
@interface StepCountModel : RLMObject
@property int timeStamp; /**< Timestamp when StepCount value was generated*/
@property int value; /**< StepCount value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Temperature DataModel
 */
@interface TemperatureModel : RLMObject
@property int timeStamp; /**< Timestamp when Temperature value was generated*/
@property int value; /**< Temperature value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief ECG DataModel
 */
@interface ECGModel : RLMObject
@property int timeStamp; /**< Timestamp when ECG value was generated*/
@property int value; /**< ECG value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Physical Activity Level/Index (PAL/PAI) DataModel
 */
@interface PAIModel : RLMObject
@property int timeStamp; /**< Timestamp when PAL value was generated*/
@property int value; /**<Reserved field*/
@property int pai; /**< PAL value*/
@property int lowTime; /**< Duration of low-intensity exercise*/
@property int moderateTime; /**< Duration of moderate-intensity exercise*/
@property int vigorousTime; /**< Duration of vigorous-intensity exercise*/
@property int extremTime; /**< Duration of strenuous exercise*/
@end

/**
 * @brief Maximum Heart Rate (HRMax) DataModel
 */
@interface HRMaxModel : RLMObject
@property int timeStamp; /**< Timestamp when HRMax value was generated*/
@property int value; /**< HRMax value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Resting Heart Rate (RestHR) DataModel
 */
@interface RestHRModel : RLMObject
@property int timeStamp; /**< Timestamp when RestHR value was generated*/
@property int value; /**< RestHR value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Calories DataModel
 */
@interface CaloriesModel : RLMObject
@property int timeStamp; /**< Timestamp when calories value was generated*/
@property int value; /**< Calories value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Sedentary DataModel
 */
@interface SedentaryModel : RLMObject
@property int timeStamp; /**< Timestamp when sedentary value was generated*/
@property int value; /**< Sedentary time*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Heart Rate Variance (HRV) DataModel
 */
@interface HRVModel : RLMObject
@property int timeStamp; /**< Timestamp when HRV value was generated*/
@property int value; /**< HRV value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Sleep DataModel
 */
@interface SleepModel : RLMObject
@property int timeStamp; /**< Timestamp when Sleep value was generated*/
@property int value; /**<Reserved field*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@property int stage; /**< The sleep stage the data producer is in*/
@property int duration; /**< Sleep duration*/
@end

/**
 * @brief Basal Metabolic Rate (BMR) DataModel
 */
@interface BMRModel : RLMObject
@property int timeStamp; /**< Timestamp when BMR value was generated*/
@property int value; /**< BMR value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@end

/**
 * @brief Atrial Fibrillation (AFib) Result DataModel
 */
@interface AFibResultModel : RLMObject
@property int timeStamp; /**< Timestamp when AFibResult was generated*/
@property int value; /**< AFib value*/
@property int state; /**< The physical state of the value producer at timeStamp @see UserPhyStatus*/
@property int type; /**< AFib result type @see AFResultDef*/
@property NSString *file; /**< URL string of RR file*/
@end

/**
 * @brief Sedentary Alert DataModel
 */
@interface SedAlertModel : RLMObject
@property int timeStamp; /**< The timestamp when the sedentary alert was triggered*/
@property int value; /**< The sedentary time*/
@end

/**
 * @brief Fall Alert DataModel
 */
@interface FallAlertModel : RLMObject
@property int timeStamp; /**< The timestamp when the fall alert was triggered*/
@property int value; /**< Whether the data producer actively responded to the fall event*/
@end

/**
 * @brief AFib Alert DataModel
 */
@interface AFibAlertModel : RLMObject
@property int timeStamp; /**< The timestamp when the AFib alert was triggered*/
@property int value; /**< AFib value*/
@end

/** @} */

/**
 * @brief Fall DataModel
 */
@interface FallModel : RLMObject
@property int timeStamp; /**< Timestamp when the data producer fell*/
@property int value; /**< Whether the data producer actively responded to the fall event*/
@property int state; /**< The physical state of the value producer at timeStamp*/
@end

// abandoned model, replaced by AFibResultModel
@interface AFibModel : RLMObject
@property int timeStamp;
@property int value;
@property int state;
@property int type;
@end

RLM_ARRAY_TYPE(HRModel);
RLM_ARRAY_TYPE(RRModel);
RLM_ARRAY_TYPE(Spo2Model);
RLM_ARRAY_TYPE(StepCountModel);
RLM_ARRAY_TYPE(TemperatureModel);
RLM_ARRAY_TYPE(ECGModel);
RLM_ARRAY_TYPE(PAIModel);
RLM_ARRAY_TYPE(HRMaxModel);
RLM_ARRAY_TYPE(RestHRModel);
RLM_ARRAY_TYPE(CaloriesModel);
RLM_ARRAY_TYPE(SedentaryModel);
RLM_ARRAY_TYPE(FallModel);
RLM_ARRAY_TYPE(HRVModel);
RLM_ARRAY_TYPE(SleepModel);
RLM_ARRAY_TYPE(BMRModel);
RLM_ARRAY_TYPE(AFibModel);
RLM_ARRAY_TYPE(SedAlertModel);
RLM_ARRAY_TYPE(FallAlertModel);
RLM_ARRAY_TYPE(AFibAlertModel);
#endif /* ModelDB_h */
