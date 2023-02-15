with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartengrundDatentypen;
with GrafikKonstanten;
with ViewKonstanten;
with EinheitenDatentypen;
with EinheitenKonstanten;
with KartenartDatentypen;
with KartenverbesserungDatentypen;

with LeseWeltkarte;
with LeseCursor;

with KartenkoordinatenberechnungssystemLogik;
with EinstellungenGrafik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with WeltkarteFeldZeichnenGrafik;
with WeltkarteZusatzZeichnenGrafik;
with WeltkarteEinheitZeichnenGrafik;
with NachGrafiktask;

package body WeltkarteGrafik is
   
   procedure WeltkarteAnzeigen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccess (ViewKonstanten.WeltKarte),
                                            GrößeExtern          => EinstellungenGrafik.AktuelleFensterAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte));
      
      Sichtbereich := SichtweitenGrafik.SichtweiteLesen;
      
      CursorKoordinatenAlt := LeseCursor.KoordinatenAlt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      Feldposition := GrafikRecordKonstanten.Nullposition;
            
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
                                             SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
            then
               IstSichtbar (KoordinatenExtern          => KartenWert,
                            EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                            PositionExtern             => Feldposition);
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
                          
         end loop XAchseSchleife;
         
         Feldposition := (0.00, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
         
      end loop YAchseSchleife;
      
      case
        LeseWeltkarteneinstellungen.YAchseNorden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Feldposition := GrafikRecordKonstanten.Nullposition;
            
         when others =>
            return;
      end case;
      
      YAchseNamenSchleife:
      for YAchseNamenSchleifenwert in -Sichtbereich .. Sichtbereich loop
         XAchseNamenSchleife:
         for XAchseNamenSchleifenwert in -Sichtbereich .. Sichtbereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => CursorKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseNamenSchleifenwert, XAchseNamenSchleifenwert),
                                                                                                      LogikGrafikExtern => False);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;    
               
            elsif
              KartenWert.YAchse > KartenDatentypen.KartenfeldPositiv'First
            then
               exit YAchseNamenSchleife;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
            then
               null;
               
            else
               case
                 LeseWeltkarte.Verbesserung (KoordinatenExtern => KartenWert)
               is
                  when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
                     WeltkarteZusatzZeichnenGrafik.StadtnameAnzeigen (KoordinatenExtern => KartenWert,
                                                                      PositionExtern    => (Feldposition.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y),
                                                                      ObenUntenExtern   => False);
                     
                  when others =>
                     null;
               end case;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
            
         end loop XAchseNamenSchleife;
         
         Feldposition := (0.00, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
         
      end loop YAchseNamenSchleife;
            
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
      
      EbeneZeichnen (KoordinatenExtern          => AktuelleKoordinaten,
                     EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                     PositionExtern             => PositionExtern,
                     TransparentsExtern         => GrafikKonstanten.Undurchsichtig,
                     EbeneExtern                => KoordinatenExtern.EAchse);
      
      if
        KoordinatenExtern.EAchse = AktuelleKoordinaten.EAchse
      then
         null;
            
      else
         EbeneZeichnen (KoordinatenExtern          => KoordinatenExtern,
                        EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                        PositionExtern             => PositionExtern,
                        TransparentsExtern         => Transparents,
                        EbeneExtern                => KoordinatenExtern.EAchse);
      end if;
      
   end IstSichtbar;
   
   
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      WeltkarteFeldZeichnenGrafik.KartenfeldZeichnen (KoordinatenExtern      => KoordinatenExtern,
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => TransparentsExtern);
      
      WeltkarteFeldZeichnenGrafik.FlussZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteFeldZeichnenGrafik.RessourceZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                     PositionExtern    => PositionExtern);
      
      
      
      WeltkarteZusatzZeichnenGrafik.WegZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                 PositionExtern    => PositionExtern);
      
      WeltkarteZusatzZeichnenGrafik.VerbesserungZeichnen (KoordinatenExtern => KoordinatenExtern,
                                                          EbeneExtern       => EbeneExtern,
                                                          PositionExtern    => PositionExtern);
      
      WeltkarteZusatzZeichnenGrafik.AnzeigeFeldbesitzer (KoordinatenExtern => KoordinatenExtern,
                                                         PositionExtern    => PositionExtern);
      
      WeltkarteZusatzZeichnenGrafik.AnzeigeFeldeffekt (KoordinatenExtern => KoordinatenExtern,
                                                       PositionExtern    => PositionExtern);
      
      
      
      WeltkarteEinheitZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern          => KoordinatenExtern,
                                                     EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                     PositionExtern             => PositionExtern);
      
      if
        NachGrafiktask.EinheitBewegungsbereich
        and
          (NachGrafiktask.Einheitenbewegung = False)
        and
          EinheitSpeziesNummerExtern.Nummer /= EinheitenKonstanten.LeerNummer
      then
         WeltkarteEinheitZeichnenGrafik.AnzeigeBewegungsfeld (KoordinatenExtern => KoordinatenExtern,
                                                              PositionExtern    => PositionExtern);
         
      else
         null;
      end if;
      
   end EbeneZeichnen;

end WeltkarteGrafik;
