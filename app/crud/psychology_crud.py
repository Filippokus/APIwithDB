from typing import Dict

from app.schemas.psychology_answers_schema import ResponseData
from fastapi import HTTPException

# Вопросы по шкале экстраверсии
EXTRAVERSION_YES = {1, 3, 8, 10, 13, 17, 22, 25, 27, 39, 44, 46, 49, 53}
EXTRAVERSION_NO = {5, 15, 20, 29, 32, 34, 37, 41, 51}

# Вопросы по шкале нейротизма
NEUROTICISM_YES = {2, 4, 7, 9, 11, 14, 16, 19, 21, 23, 26, 28, 31, 33, 35, 38, 40, 43, 45, 47, 50, 52, 55, 57}

# Вопросы по шкале ложных ответов
LIE_YES = {6, 24, 36}
LIE_NO = {12, 18, 30, 42, 48, 54}


def calculate_score(responses, yes_set, no_set):
    return sum(1 for i, response in enumerate(responses, start=1)
               if (i in yes_set and response == 1) or (i in no_set and response == 0))


def evaluate_extraversion(score):
    if score > 19:
        return "яркий экстраверт"
    elif score > 15:
        return "экстраверт"
    elif score > 12:
        return "склонность к экстраверсии"
    elif score == 12:
        return "среднее значение"
    elif score > 9:
        return "склонность к интроверсии"
    elif score > 5:
        return "интроверт"
    else:
        return "глубокий интроверт"


def evaluate_neuroticism(score):
    if score > 19:
        return "очень высокий уровень нейротизма"
    elif score > 13:
        return "высокий уровень нейротизма"
    elif score >= 9:
        return "среднее значение"
    else:
        return "низкий уровень нейротизма"


def evaluate_lie(score):
    if score > 4:
        return "Ответы в норме"
    else:
        return "Ответы ложные"


def analyze_temperament(extraversion, neurotism):
    if extraversion > 12 and neurotism < 9:
        return "сангвиник"
    elif extraversion > 12 and neurotism > 13:
        return "холерик"
    elif extraversion < 12 and neurotism > 13:
        return "меланхолик"
    elif extraversion < 12 and neurotism < 9:
        return "флегматик"
    else:
        return "средний темперамент"


def analyze_responses(data: ResponseData) -> Dict[str, any]:
    responses = data.psyresult

    if len(responses) != 57:
        raise HTTPException(status_code=400, detail="Должно быть 57 ответов.")

    extraversion_score = calculate_score(responses, EXTRAVERSION_YES, EXTRAVERSION_NO)
    neuroticism_score = calculate_score(responses, NEUROTICISM_YES, set())
    lie_score = calculate_score(responses, LIE_YES, LIE_NO)

    temperament = analyze_temperament(extraversion_score, neuroticism_score)
    extraversion_result = evaluate_extraversion(extraversion_score)
    neuroticism_result = evaluate_neuroticism(neuroticism_score)
    lie_result = evaluate_lie(lie_score)

    psyresult = {
        "temperament": temperament,
        "extraversion_result": extraversion_result,
        "neuroticism_result": neuroticism_result,
        "lie_result": lie_result
    }

    return {
        "userid": data.userid,
        "psyresult": psyresult
    }
