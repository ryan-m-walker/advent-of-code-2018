(def input
  (->> (slurp "input.txt")
       clojure.string/split-lines
       (map #(Integer/parseInt %))))

(defn find-first-repeat [changes]
  (loop [freq 0
         seen #{0}
         remaining (cycle changes)]
    (let [freq (+ freq (first remaining))]
      (if (contains? seen freq)
        freq
        (recur freq (conj seen freq) (rest remaining))))))

(println (find-first-repeat input))
