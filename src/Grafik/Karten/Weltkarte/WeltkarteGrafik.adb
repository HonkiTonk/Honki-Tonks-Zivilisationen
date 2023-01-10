with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartengrundDatentypen;
with GrafikKonstanten;
with ViewKonstanten;

with LeseWeltkarte;
with LeseCursor;

with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;
with ViewsEinstellenGrafik;
with WeltkarteZeichnenGrafik;
with SichtweitenGrafik;

package body WeltkarteGrafik is
   
   procedure WeltkarteAnzeigen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltKarte),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte));
      
      Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
      
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      Feldposition := (0.00, 0.00);
            
      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtbereich .. Sichtbereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              True = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                             SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies)
            then
               IstSichtbar (KoordinatenExtern        => KartenWert,
                            EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                            PositionExtern           => Feldposition);
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.KartenfelderAbmessung.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (0.00, Feldposition.y + SichtweitenGrafik.KartenfelderAbmessung.y);
         
      end loop YAchseSchleife;
            
   end WeltkarteAnzeigen;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.Ebene;
   begin
      
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
            when KartenKonstanten.WeltraumKonstante =>
               AktuelleKoordinaten := (KoordinatenExtern.EAchse - 1, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse);
               Transparents := GrafikKonstanten.Weltraumtransparents;
            
            when KartenKonstanten.OberflächeKonstante =>
               -- Hier eventuell später noch den aktuellen Grund berücksichtigen oder ist der bei Wasser niemals wichtig? äöü
               if
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
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
                                             EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             PositionExtern           => PositionExtern,
                                             TransparentsExtern       => GrafikKonstanten.Undurchsichtig,
                                             EbeneExtern              => KoordinatenExtern.EAchse);
      
      if
        KoordinatenExtern.EAchse = AktuelleKoordinaten.EAchse
      then
         null;
            
      else
         WeltkarteZeichnenGrafik.EbeneZeichnen (KoordinatenExtern        => KoordinatenExtern,
                                                EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                PositionExtern           => PositionExtern,
                                                TransparentsExtern       => Transparents,
                                                EbeneExtern              => KoordinatenExtern.EAchse);
      end if;
      
   end IstSichtbar;

end WeltkarteGrafik;
