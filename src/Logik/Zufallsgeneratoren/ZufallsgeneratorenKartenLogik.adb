with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body ZufallsgeneratorenKartenLogik is
   
   function KartengeneratorZufallswerte
     return SystemDatentypen.NullBisHundert
   is begin
      
      ZufälligeZahl.Reset (Gen => ZufälligeZahlGewählt);
      return ZufälligeZahl.Random (Gen => ZufälligeZahlGewählt);
      
   end KartengeneratorZufallswerte;
   
   
   
   function KartengeneratorLandgrößen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Minimalwert.YAchse := KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse;
      Maximalwert.YAchse := KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse;
      
      Minimalwert.XAchse := KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse;
      Maximalwert.XAchse := KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse;
            
      if
        Minimalwert.YAchse > LeseWeltkarteneinstellungen.YAchse
      then
         Minimalwert.YAchse := LeseWeltkarteneinstellungen.YAchse;
               
      else
         null;
      end if;
            
      if
        Maximalwert.YAchse > LeseWeltkarteneinstellungen.YAchse
      then
         Maximalwert.YAchse := LeseWeltkarteneinstellungen.YAchse;
               
      else
         null;
      end if;

            
      if
        Minimalwert.XAchse > LeseWeltkarteneinstellungen.XAchse
      then
         Minimalwert.XAchse := LeseWeltkarteneinstellungen.XAchse;
               
      else
         null;
      end if;
            
      if
        Maximalwert.XAchse > LeseWeltkarteneinstellungen.XAchse
      then
         Maximalwert.XAchse := LeseWeltkarteneinstellungen.XAchse;
               
      else
         null;
      end if;
      
      if
        Minimalwert.YAchse > Maximalwert.YAchse
      then
         Zwischenspeicher.YAchse := Minimalwert.YAchse;
         Minimalwert.YAchse := Maximalwert.YAchse;
         Maximalwert.YAchse := Zwischenspeicher.YAchse;

      else
         null;
      end if;
      
      if
        Minimalwert.XAchse > Maximalwert.XAchse
      then
         Zwischenspeicher.XAchse := Minimalwert.XAchse;
         Minimalwert.XAchse := Maximalwert.XAchse;
         Maximalwert.XAchse := Zwischenspeicher.XAchse;

      else
         null;
      end if;
      
      ZufälligeSenkrechteLandgrößen.Reset (Gen => ZufälligeSenkrechteLandgrößeGewählt);
      ZufälligeWaagerechteLandgrößen.Reset (Gen => ZufälligeWaagerechteLandgrößeGewählt);
      
      return (ZufälligeSenkrechteLandgrößen.Random (Gen   => ZufälligeSenkrechteLandgrößeGewählt,
                                                       First => Minimalwert.YAchse,
                                                       Last  => Maximalwert.YAchse),
              ZufälligeWaagerechteLandgrößen.Random (Gen   => ZufälligeWaagerechteLandgrößeGewählt,
                                                        First => Minimalwert.XAchse,
                                                        Last  => Maximalwert.XAchse));
              
   end KartengeneratorLandgrößen;

end ZufallsgeneratorenKartenLogik;
