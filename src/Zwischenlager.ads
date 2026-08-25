if
                 False = LadenSichtbarkeitLogik.AufteilungSpezienzusammenfassung (DateiLadenExtern        => DateiLadenExtern,
                                                            KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                            VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                            LadenPrüfenExtern       => LadenPrüfenExtern)
               then
                  return False;
