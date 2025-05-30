with KartenKonstanten;
with GrafikRecordKonstanten;
with Views;
with KartengrundDatentypen;
with GrafikKonstanten;
with ViewKonstanten;
with EinheitenKonstanten;
with KartenartDatentypen;
with KartenverbesserungDatentypen;
with SystemDatentypen;

with LeseWeltkarte;
with LeseZeiger;
with LeseEinstellungenGrafik;
with LeseGrafiktask;

with KartenkoordinatenberechnungssystemLogik;
with ViewsEinstellenGrafik;
with SichtweitenGrafik;
with WeltkarteFeldZeichnenGrafik;
with WeltkarteZusatzZeichnenGrafik;
with WeltkarteEinheitZeichnenGrafik;
with FensterGrafik;

package body WeltkarteGrafik is
   
   procedure WeltkarteAnzeigen
     (EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord)
   is begin
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.WeltkarteAccesse (ViewKonstanten.WeltKarte),
                                            GrößeExtern          => FensterGrafik.AktuelleAuflösung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Weltkartenbereich (ViewKonstanten.WeltKarte));
      
      Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
      
      ZeigerKoordinatenAlt := LeseZeiger.KoordinatenAlt (SpeziesExtern => EinheitenauswahlExtern.SpeziesNummer.Spezies);
      Feldposition := GrafikRecordKonstanten.Nullposition;
            
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Sichtbereich.Senkrechte .. Sichtbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Sichtbereich.Waagerechte .. Sichtbereich.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => ZeigerKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              True = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                             SpeziesExtern     => EinheitenauswahlExtern.SpeziesNummer.Spezies)
            then
               IstSichtbar (KoordinatenExtern      => KartenWert,
                            EinheitenauswahlExtern => EinheitenauswahlExtern,
                            PositionExtern         => Feldposition);
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
                          
         end loop WaagerechteSchleife;
         
         Feldposition := (GrafikKonstanten.Nullwert, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
         
      end loop SenkrechteSchleife;
            
      case
        LeseWeltkarteneinstellungen.SenkrechteNorden
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum =>
            Feldposition := GrafikRecordKonstanten.Nullposition;
            Stadtnamenposition := 0;
            
         when others =>
            return;
      end case;
      
      SenkrechteamenSchleife:
      for SenkrechteamenSchleifenwert in -Sichtbereich.Senkrechte .. Sichtbereich.Senkrechte loop
         WaagerechteamenSchleife:
         for WaagerechteamenSchleifenwert in -Sichtbereich.Waagerechte .. Sichtbereich.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => ZeigerKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteamenSchleifenwert, WaagerechteamenSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                              SpeziesExtern     => EinheitenauswahlExtern.SpeziesNummer.Spezies)
            then
               null;
               
            elsif
              LeseWeltkarte.Verbesserung (KoordinatenExtern => KartenWert) in KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range
            then
               if
                 Stadtnamenposition = Integer (Sichtbereich.Senkrechte + Sichtbereich.Senkrechte)
               then
                  WeltkarteZusatzZeichnenGrafik.StadtnameAnzeigen (KoordinatenExtern => KartenWert,
                                                                   PositionExtern    => (Feldposition.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y),
                                                                   ObenUntenExtern   => True);
                     
               else
                  WeltkarteZusatzZeichnenGrafik.StadtnameAnzeigen (KoordinatenExtern => KartenWert,
                                                                   PositionExtern    => (Feldposition.x, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y),
                                                                   ObenUntenExtern   => False);
               end if;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + SichtweitenGrafik.Kartenfeldfläche.x;
            
         end loop WaagerechteamenSchleife;
         
            Feldposition := (GrafikKonstanten.Nullwert, Feldposition.y + SichtweitenGrafik.Kartenfeldfläche.y);
            
            Stadtnamenposition := Stadtnamenposition + 1;
         
      end loop SenkrechteamenSchleife;
            
   end WeltkarteAnzeigen;
   
   
   
   procedure IstSichtbar
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      if
        LeseEinstellungenGrafik.EbenenUnterhalbSichtbar = True
      then
         case
           KoordinatenExtern.Ebene
         is
            when KartenKonstanten.HimmelKonstante =>
               AktuelleKoordinaten := (KoordinatenExtern.Ebene - 1, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte);
               Transparents := GrafikKonstanten.Wolkentransparents;
            
               -- Dafür was besseres einbauen. äöü
            when KartenKonstanten.WeltraumKonstante =>
               AktuelleKoordinaten := (KoordinatenExtern.Ebene - 1, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte);
               Transparents := GrafikKonstanten.Weltraumtransparents;
            
            when KartenKonstanten.OberflächeKonstante =>
               if
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) in KartengrundDatentypen.Basisgrund_Oberfläche_Wasser_Enum'Range
               then
                  AktuelleKoordinaten := (KoordinatenExtern.Ebene - 1, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte);
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
      
      EbeneZeichnen (KoordinatenExtern      => AktuelleKoordinaten,
                     EinheitenauswahlExtern => EinheitenauswahlExtern,
                     PositionExtern         => PositionExtern,
                     TransparentsExtern     => GrafikKonstanten.Undurchsichtig,
                     EbeneExtern            => KoordinatenExtern.Ebene);
      
      if
        KoordinatenExtern.Ebene = AktuelleKoordinaten.Ebene
      then
         null;
            
      else
         EbeneZeichnen (KoordinatenExtern      => KoordinatenExtern,
                        EinheitenauswahlExtern => EinheitenauswahlExtern,
                        PositionExtern         => PositionExtern,
                        TransparentsExtern     => Transparents,
                        EbeneExtern            => KoordinatenExtern.Ebene);
      end if;
      
   end IstSichtbar;
   
   
   
   procedure EbeneZeichnen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      EinheitenauswahlExtern : in EinheitenGrafikRecords.EinheitGrafikRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      TransparentsExtern : in Sf.sfUint8;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden)
   is begin
      
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
      
      
      
      WeltkarteEinheitZeichnenGrafik.AnzeigeEinheit (KoordinatenExtern      => KoordinatenExtern,
                                                     EinheitenauswahlExtern => EinheitenauswahlExtern,
                                                     PositionExtern         => PositionExtern);
      
      if
        LeseGrafiktask.Einheitenbewegungsbereich
        and
          LeseGrafiktask.Einheitenbewegung = False
        and
          EinheitenauswahlExtern.SpeziesNummer.Nummer /= EinheitenKonstanten.LeerNummer
      then
         WeltkarteEinheitZeichnenGrafik.AnzeigeBewegungsfeld (KoordinatenExtern => KoordinatenExtern,
                                                              PositionExtern    => PositionExtern);
         
      else
         null;
      end if;
      
   end EbeneZeichnen;

end WeltkarteGrafik;
