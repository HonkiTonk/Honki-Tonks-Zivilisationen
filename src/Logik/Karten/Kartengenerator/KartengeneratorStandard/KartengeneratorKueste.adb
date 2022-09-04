pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with SchreibeKarten;
with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with LadezeitenLogik;

package body KartengeneratorKueste is

   procedure GenerierungKüstenSeeGewässer
   is begin
      
      Multiplikator := 1;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Karteneinstellungen.Kartengröße.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Karteneinstellungen.Kartengröße.XAchse loop
                              
            case
              LeseKarten.AktuellerGrund (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Wasser_Enum =>
                  GewässerFestlegen (KoordinatenExtern => (0, YAchseSchleifenwert, XAchseSchleifenwert));
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
            
         if
           ZahlenDatentypen.EigenesPositive (YAchseSchleifenwert) >= Multiplikator * ZahlenDatentypen.EigenesPositive (Karten.Karteneinstellungen.Kartengröße.YAchse) / 100
         then
            LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Küstenwasser_Enum);
            Multiplikator := Multiplikator + 1;
               
         else
            null;
         end if;
         
      end loop YAchseSchleife;
      
   end GenerierungKüstenSeeGewässer;
   
   
   
   procedure GewässerFestlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
                     
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                 ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
                        
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Flachland_Enum
              or
                LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
            then
               SchreibeKarten.GleicherGrund (KoordinatenExtern => KoordinatenExtern,
                                            GrundExtern       => KartengrundDatentypen.Küstengewässer_Enum);
               return;
               
            else
               null;
            end if;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end GewässerFestlegen;

end KartengeneratorKueste;
