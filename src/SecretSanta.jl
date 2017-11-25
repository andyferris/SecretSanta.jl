module SecretSanta

function secret_santa(people::Array{String}, path::String = ENV["HOME"])
    n_people = length(people)

    if n_people < 2
        error("Need to provide at least two people to exchange gifts")
    end
    
    srand()
    perm = randperm(n_people)
    while some_same(perm) # Make sure no-one gifts themselves
        perm = randperm(n_people)
    end

    for i ∈ 1:n_people
        giver = people[i]
        receiver = people[perm[i]]

        open(joinpath(path, "$(giver).txt"), "w") do io
            write(io, """
                Dear $(giver),
                
                For Secret Santa, please provide a gift for $(receiver).

                Kind regards,
                Julia
                """)
        end
    end
end

function some_same(perm)
    for i ∈ 1:length(perm)
        if i == perm[i]
            return true
        end
    end
    return false
end

end # module
