pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartengrundDatentypen;
with GrafikKonstanten;

with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with KartenberechnungenGrafik;
with EinstellungenGrafik;
with ViewsEinstellenGrafik;
with WeltkarteZeichnenGrafik;
with SichtweitenGrafik;

package body WeltkarteGrafik is
   
   procedure WeltkarteAnzeigen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.KartenviewAccess,
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.KarteAnzeigebereich);
      
      SichtbereichAnfangEnde := SichtweitenGrafik.SichtbereichKarteBerechnen;
      
      CursorKoordinatenAlt := SpielVariablen.CursorImSpiel (EinheitRasseNummerExtern.Rasse).KoordinatenAlt;
      Feldposition := (0.00, 0.00);
            
      YAchseSchleife:
      for YAchseSchleifenwert in SichtbereichAnfangEnde (1) .. SichtbereichAnfangEnde (2) loop
         XAchseSchleife:
         for XAchseSchleifenwert in SichtbereichAnfangEnde (3) .. SichtbereichAnfangEnde (4) loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                             RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               IstSichtbar (KoordinatenExtern        => KartenWert,
                            EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                            PositionExtern           => Feldposition);
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + KartenberechnungenGrafik.KartenfelderAbmessung.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (0.00, Feldposition.y + KartenberechnungenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
            
   end WeltkarteAnzeigen;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      if
        EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar
      then
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
                 LeseWeltkarte.BasisGrund (KoordinatenExtern => KoordinatenExtern) in KartengrundDatentypen.Kartengrund_Oberfläche_Wasser_Enum'Range
               then
                  AktuelleKoordinaten := (KoordinatenExtern.EAchse - 1, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
                  Transparents := GrafikKonstanten.Wassertransparents;
               
               else
                  AktuelleKoordinaten := KoordinatenExtern;
                  Transparents := GrafikKonstanten.Undurchsichtig;
               end if;
            
            when others =>
               AktuelleKoordinaten := KoordinatenExtern;
         end case;
         
      else
         AktuelleKoordinaten := KoordinatenExtern;
         Transparents := GrafikKonstanten.Undurchsichtig;
      end if;
      
      WeltkarteZeichnenGrafik.EbeneZeichnen (KoordinatenExtern        => AktuelleKoordinaten,
                                             EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                             PositionExtern           => PositionExtern,
                                             TransparentsExtern       => GrafikKonstanten.Undurchsichtig,
                                             EbeneExtern              => KoordinatenExtern.EAchse);
      
      if
        KoordinatenExtern.EAchse = AktuelleKoordinaten.EAchse
      then
         null;
            
      else
         WeltkarteZeichnenGrafik.EbeneZeichnen (KoordinatenExtern        => KoordinatenExtern,
                                                EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                PositionExtern           => PositionExtern,
                                                TransparentsExtern       => Transparents,
                                                EbeneExtern              => KoordinatenExtern.EAchse);
      end if;
      
   end IstSichtbar;

end WeltkarteGrafik;
