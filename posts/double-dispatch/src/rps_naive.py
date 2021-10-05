def play_rock_paper_scissors(first_hand, second_hand):
    if (first_hand == second_hand):
        return 'Draw'

    if (first_hand == 'Rock'):
        if (second_hand == 'Paper'):
            return 'Paper'
        else:
            return 'Rock'
    elif (first_hand == 'Paper'):
        if (second_hand == 'Rock'):
            return 'Paper'
        else:
            return 'Scissors'
    else:
        if (second_hand == 'Rock'):
            return 'Rock'
        else:
            return 'Scissors'