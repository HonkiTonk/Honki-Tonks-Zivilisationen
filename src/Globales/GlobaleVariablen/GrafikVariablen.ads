with GrafikRecordKonstanten;
with Views;
with ViewKonstanten;

package GrafikVariablen is

   InformationsfeldBereiche : GrafikRecordKonstanten.BereicheArray (Views.InformationsfeldAccesse'Range) := (
                                                                                                             ViewKonstanten.InformationsfeldStadtkarte  => (0.00, 0.00, 0.40, 0.40),
                                                                                                             ViewKonstanten.InformationenFeldproduktion => (0.00, 0.00, 1.00, 1.00)
                                                                                                            );

end GrafikVariablen;
