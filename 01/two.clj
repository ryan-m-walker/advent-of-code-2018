(require '[clojure.string :as str])

(defn calc
  "Find the first frequency that is reached twice. The list of shifts is
  cycled endlessly and `reductions` gives us the lazy sequence of running
  totals, so we just walk it until we hit a total we have already seen."
  [shifts]
  ;; the running totals are bound inside `loop` rather than in a `let` so that
  ;; nothing holds on to the head of the (infinite) sequence as we consume it
  (loop [totals (reductions + 0 (map #(Long/parseLong %) (cycle shifts)))
         seen #{}]
    (let [total (first totals)]
      (if (contains? seen total)
        total
        (recur (rest totals) (conj seen total))))))

(let [shifts (->> (slurp "input.txt")
                  str/split-lines
                  (remove str/blank?))]
  (println "FOUND:" (calc shifts)))
