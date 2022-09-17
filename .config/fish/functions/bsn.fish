function bsn
    bsn::init
    set -l opts deduct add balance reset help
    set -l opts_noval help balance
    if contains -- (bsn::complete $argv[1]) $opts
        if not set -q argv[2]; and not contains -- (bsn::complete $argv[1]) $opts_noval
            bsn::print err "Value not provided for subcommand: '$(bsn::complete $argv[1])'"
            return 1
        end

        set -l cmd (bsn::complete $argv[1])
        bsn::$cmd $argv
    else if not set -q argv[1]
        bsn::print warn "Missing subcommand, available subcommands: $(string join ', ' $opts)"
    else
        bsn::print warn "Invalid subcommand, available subcommands: $(string join ', ' $opts)"
    end
end

function bsn::verify_int --no-scope-shadowing
    if not math 1 - $argv[2] &>/dev/null
        switch $argv[1]
            case deduct
                bsn::print err "Invalid value provided, not deducting card balance"
                # set value 0
            case reset
                bsn::print err "Invalid value provided, not changing card balance"
                # set value $bsn_balance
        end

        return 1
    end
end

function bsn::deduct
    set -l value $argv[2]
    bsn::verify_int deduct $value
    or return 1

    set bsn_last_transaction -$value

    bsn::print half-bold "Old card balance:" "RM$bsn_balance"
    set bsn_balance (math $bsn_balance - $value)

    bsn::print half-bold "Deduction amount:" "RM$value"
    bsn::print half-bold "New card balance:" "RM$bsn_balance"
end

function bsn::add
    set -l value $argv[2]
    bsn::verify_int add $value
    or return 1

    set bsn_last_transaction +$value
    set bsn_balance (math $bsn_balance + $value)
end

function bsn::balance
    if test "$bsn_balance" -lt 100 -a "$bsn_balance" -ge 50
        bsn::print warn "Card balance: RM$bsn_balance"
    else if test "$bsn_balance" -lt 50
        bsn::print red "Card balance: RM$bsn_balance"
    else
        bsn::print info "Card balance: RM$bsn_balance"
    end
    bsn::print dark "Last transaction: $bsn_last_transaction"
end

function bsn::reset
    set -l value $argv[2]
    bsn::verify_int reset $value
    or return 1

    read -n1 -p "echo 'Continue setting balance to RM$value?[y/N]: '" prompt
    if test (string lower $prompt) = y
        set bsn_balance $value
    end
end

function bsn::init
    if not set -q bsn_init
        bsn::print info "Doing first-time initialization..."
        set -U bsn_init
        set -U bsn_balance 0
        set -U bsn_last_transaction 0
    end

    return 0
end

function bsn::complete
    switch $argv[1]
        case ded deduct
            echo deduct
        case add
            echo add
        case bal balance
            echo balance
        case res reset
            echo reset
        case help
            echo help
        case '*'
            return 1
    end
end

function bsn::help
    echo \
"
$(set_color --bold)SUBCOMMANDS$(set_color normal)
    $(set_color cyan)bal$(set_color normal)ance - Print card balance and last deduction amount
    $(set_color cyan)ded$(set_color normal)uct  - Deduct N amount from card balance
    $(set_color cyan)add$(set_color normal)     - Add N amount to the card balance
    $(set_color cyan)res$(set_color normal)et   - Set new card balance value
    $(set_color cyan)help$(set_color normal)    - Print this help message
"
end

# Colours
function bsn::print
    switch $argv[1]
        case err
            set_color brred
            echo $argv[2]
            set_color normal
        case warn
            set_color yellow
            echo $argv[2]
            set_color normal
        case info
            set_color green
            echo $argv[2]
            set_color normal
        case red low
            set_color red
            echo $argv[2]
            set_color normal
        case dark
            set_color brblack
            echo $argv[2]
            set_color normal
        case hbold half-bold
            set_color brwhite
            echo -n (set_color --bold)$argv[2](set_color normal) $argv[3] \n
    end
end
