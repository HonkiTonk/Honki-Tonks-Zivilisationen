pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartengrundDatentypen;
with GrafikKonstanten;

with LeseKarten;

with Kartenkoordinatenberechnungssystem;
with KartenberechnungenGrafik;
with EinstellungenGrafik;
with ViewsEinstellenGrafik;
with WeltkarteZeichnenGrafik;
with Sichtweiten;

package body WeltkarteGrafik is
   
   procedure Weltkarte
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                          GrößeExtern          => (EinstellungenGrafik.AktuelleFensterAuflösung.x, EinstellungenGrafik.AktuelleFensterAuflösung.y),
                                          AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
      SichtbereichAnfangEnde := Sichtweiten.SichtbereichKarteBerechnen;
      
      CursorKoordinatenAlt := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt;
      Feldposition := (0.00, 0.00);
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
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
               IstSichtbar (KoordinatenExtern  => KartenWert,
                            RasseEinheitExtern => EinheitRasseNummerExtern,
                            PositionExtern     => Feldposition);
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + KartenberechnungenGrafik.KartenfelderAbmessung.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (0.00, Feldposition.y + KartenberechnungenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
            
   end Weltkarte;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseEinheitExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Transparents := GrafikKonstanten.Undurchsichtig;
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            AktuelleKoordinaten := (KoordinatenExtern.EAchse - 1, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
            Transparents := GrafikKonstanten.Wolkentransparents;
            
            -- Dafür was besseres einbauen. äöü
            -- when KartenKonstanten.WeltraumKonstante =>
            -- AktuelleKoordinaten := (KoordinatenExtern.EAchse - 2, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
            -- Transparents := GrafikKonstanten.Weltraumtransparents;
            
         when KartenKonstanten.OberflächeKonstante =>
            -- Hier eventuell später noch den aktuellen Grund berücksichtigen oder ist der bei Wasser niemals wichtig? äöü
            if
              LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern) in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range
            then
               AktuelleKoordinaten := (KoordinatenExtern.EAchse - 1, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
               Transparents := GrafikKonstanten.Wassertransparents;
               
            else
               AktuelleKoordinaten := KoordinatenExtern;
            end if;
            
         when others =>
            AktuelleKoordinaten := KoordinatenExtern;
      end case;
      
      WeltkarteZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern      => AktuelleKoordinaten,
                                                  PositionExtern         => PositionExtern,
                                                  DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      
      WeltkarteZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.FlussZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                             PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.WegZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                           PositionExtern    => PositionExtern);
      
      WeltkarteZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => AktuelleKoordinaten,
                                                    EbeneExtern       => KoordinatenExtern.EAchse,
                                                    PositionExtern    => PositionExtern);
      
      -- Put_Line ("E: " & AktuelleKoordinaten.EAchse'Wide_Wide_Image & "   Y: " & AktuelleKoordinaten.YAchse'Wide_Wide_Image & "    X: " & AktuelleKoordinaten.XAchse'Wide_Wide_Image);
      -- Put_Line ("Rasse: " & RasseEinheitExtern.Rasse'Wide_Wide_Image & "    Nummer: " & RasseEinheitExtern.Nummer'Wide_Wide_Image);
      -- New_Line (2);
      
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
         WeltkarteZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern      => KoordinatenExtern,
                                                     PositionExtern         => PositionExtern,
                                                     DurchsichtigkeitExtern => Transparents);
      
         WeltkarteZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                    PositionExtern    => PositionExtern);
      
         WeltkarteZeichnenGrafik.WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                                              PositionExtern    => PositionExtern);
      
         WeltkarteZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                       EbeneExtern       => KoordinatenExtern.EAchse,
                                                       PositionExtern    => PositionExtern);
         
         WeltkarteZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern  => KoordinatenExtern,
                                                 RasseEinheitExtern => RasseEinheitExtern,
                                                 PositionExtern     => PositionExtern);
      
         WeltkarteZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                                                      PositionExtern    => PositionExtern);
      end if;
      
   end IstSichtbar;

end WeltkarteGrafik;
