(require '[clojure.string :as str])

(defn calc [input]
  (reduce + (map #(Integer/parseInt %) input)))

(let [input (->> (slurp "input.txt")
                 (str/split-lines)
                 (remove str/blank?))]
  (println (calc input)))
