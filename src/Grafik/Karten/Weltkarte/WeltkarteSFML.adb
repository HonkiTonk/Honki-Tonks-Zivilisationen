pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with BerechnungenKarteSFML;
with GrafikEinstellungenSFML;
with ViewsEinstellenSFML;
with WeltkarteZeichnenGrafik;

package body WeltkarteSFML is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      ViewsEinstellenSFML.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                          GrößeExtern          => (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x, GrafikEinstellungenSFML.AktuelleFensterAuflösung.y),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
      SichtbereichAnfangEnde := BerechnungenKarteSFML.SichtbereichKarteBerechnen;
      
      YMultiplikator := 0.00;
      CursorKoordinatenAlt := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt;
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         
         XMultiplikator := 0.00;
         
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                          RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               -- Die Position durchzureichen bedeutet auch gleichzeitig den aktuellen Multiplikator mit durchzureichen!
               Position.x := XMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.x;
               Position.y := YMultiplikator * BerechnungenKarteSFML.KartenfelderAbmessung.y;
               
               IstSichtbar (KoordinatenExtern  => KartenWert,
                            RasseEinheitExtern => EinheitRasseNummerExtern,
                            PositionExtern     => Position);
               
            else
               null;
            end if;
            
            XMultiplikator := XMultiplikator + 1.00;
                          
         end loop XAchseSchleife;
         
         YMultiplikator := YMultiplikator + 1.00;
         
      end loop YAchseSchleife;
            
   end Weltkarte;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      -- Das dann auch auf Orbit und normales Wasser erweitern? äöü
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            AktuelleKoordinaten := (KoordinatenExtern.EAchse - 1, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
            
         when others =>
            AktuelleKoordinaten := KoordinatenExtern;
      end case;
            
      -- Landschaft
      WeltkarteZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern  => AktuelleKoordinaten,
                                                  PositionExtern     => PositionExtern,
                                                  DurchsichtigExtern => False);
      
      WeltkarteZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.FlussZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                             PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.WegZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                           PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                                    PositionExtern    => PositionExtern);
      -- Landschaft
      
      
      
      WeltkarteZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern  => AktuelleKoordinaten,
                                              RasseEinheitExtern => RasseEinheitExtern,
                                              PositionExtern     => PositionExtern);
      
      WeltkarteZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => AktuelleKoordinaten,
                                                   PositionExtern    => PositionExtern);
      
      if
        KoordinatenExtern.EAchse = AktuelleKoordinaten.EAchse
      then
         null;
            
      else
         WeltkarteZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern  => KoordinatenExtern,
                                                     PositionExtern     => PositionExtern,
                                                     DurchsichtigExtern => True);
      
         WeltkarteZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                       PositionExtern    => PositionExtern);
         
         WeltkarteZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern  => KoordinatenExtern,
                                                 RasseEinheitExtern => RasseEinheitExtern,
                                                 PositionExtern     => PositionExtern);
      
         WeltkarteZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                                                      PositionExtern    => PositionExtern);
      end if;
      
   end IstSichtbar;

end WeltkarteSFML;
