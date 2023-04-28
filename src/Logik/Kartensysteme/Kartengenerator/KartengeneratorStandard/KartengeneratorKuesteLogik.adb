with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeWeltkarte;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with LadezeitenLogik;

package body KartengeneratorKuesteLogik is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      -- Diese Berechnung mal in eine eigene Datei verschieben und durch ein Generic nutzen? äöü
      Kartenzeitwert := (LeseWeltkarteneinstellungen.YAchse + (100 - 1)) / 100;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
                              
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Wasser_Enum =>
                  GewässerFestlegen (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         case
           YAchseSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                     
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
                        
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            else
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert)
               is
                  when KartengrundDatentypen.Flachland_Enum | KartengrundDatentypen.Eis_Enum =>
                     SchreibeWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern,
                                                   GrundExtern       => KartengrundDatentypen.Küstengewässer_Enum);
                     return;
                     
                  when others =>
                     null;
               end case;
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GewässerFestlegen;

end KartengeneratorKuesteLogik;
