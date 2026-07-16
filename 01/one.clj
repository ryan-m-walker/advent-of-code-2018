(require '[clojure.string :as str])

(defn calc [input]
  ;; parse each line as an int (parseInt accepts the leading + sign)
  ;; and sum them into the resulting frequency
  (reduce + (map #(Integer/parseInt %) input)))

(let [input (str/split-lines (slurp "input.txt"))]
  (println (calc input)))
