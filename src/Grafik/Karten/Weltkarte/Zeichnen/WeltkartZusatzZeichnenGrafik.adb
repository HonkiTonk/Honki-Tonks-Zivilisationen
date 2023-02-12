with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with KartengrundDatentypen;
with SpeziesKonstanten;
with KartenKonstanten;
with TextaccessVariablen;
with GrafikKonstanten;
with GrafikRecordKonstanten;

with LeseWeltkarte;
with LeseStadtGebaut;

with TextberechnungenBreiteGrafik;
with SpezieseinstellungenGrafik;
with TextberechnungenHoeheGrafik;
with KartenkoordinatenberechnungssystemLogik;
with TextaccessverwaltungssystemGrafik;
with StadtSuchenLogik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with ObjekteZeichnenGrafik;
with SichtweitenGrafik;

package body WeltkartZusatzZeichnenGrafik is

   procedure WegZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      Wegfeld := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
      
      case
        Wegfeld
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.WegeAccess (Wegfeld),
                                                            PositionExtern         => PositionExtern,
                                                            DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end case;
      
   end WegZeichnen;
   
   
   
   procedure VerbesserungZeichnen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EbeneExtern : in KartenDatentypen.EbeneVorhanden;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Verbesserungsfeld := LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern);
      
      case
        Verbesserungsfeld
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            return;
            
         when KartenverbesserungDatentypen.Karten_Verbesserung_Städte_Enum =>
            if
              KoordinatenExtern.EAchse = EbeneExtern
            then
               StadtnameAnzeigen (KoordinatenExtern => KoordinatenExtern,
                                  PositionExtern    => PositionExtern);
               
            else
               null;
            end if;
               
         when others =>
            null;
      end case;
      
      KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.VerbesserungenAccess (Verbesserungsfeld),
                                                      PositionExtern         => PositionExtern,
                                                      DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      
   end VerbesserungZeichnen;
   
   
   
   procedure AnzeigeFeldbesitzer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      AktuelleSpezies := LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => KoordinatenExtern);
      
      case
        AktuelleSpezies
      is
         when SpeziesKonstanten.LeerSpezies =>
            null;
            
         when others =>
            RahmenBesetztesFeld (KoordinatenExtern => KoordinatenExtern,
                                 PositionExtern    => PositionExtern,
                                 SpeziesExtern     => AktuelleSpezies);
      end case;
            
   end AnzeigeFeldbesitzer;
   
   
   
   procedure RahmenBesetztesFeld
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => PositionExtern,
                                                FarbeExtern    => SpezieseinstellungenGrafik.Speziesfarben (SpeziesExtern),
                                                GrößeExtern    => SichtweitenGrafik.Kartenfeldfläche);
      
      UmgebungSchleife:
      for UmgebungSchleifenwert in UmgebungArray'Range loop
         
         KartenWertRahmen := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                         ÄnderungExtern    => Umgebung (UmgebungSchleifenwert),
                                                                                                         LogikGrafikExtern => False);
               
         if
           KartenWertRahmen.XAchse = KartenKonstanten.LeerXAchse
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            SpeziesExtern        => SpeziesExtern);
                     
         elsif
           SpeziesExtern /= LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => KartenWertRahmen)
         then
            RahmenZeichnen (WelcheRichtungExtern => UmgebungSchleifenwert,
                            PositionExtern       => PositionExtern,
                            SpeziesExtern        => SpeziesExtern);

         else
            null;
         end if;
            
      end loop UmgebungSchleife;
      
   end RahmenBesetztesFeld;



   procedure RahmenZeichnen
     (WelcheRichtungExtern : in KartenartDatentypen.Himmelsrichtungen_Enum;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
            
      case
        WelcheRichtungExtern
      is
         when KartenartDatentypen.Norden_Enum =>
            Rahmengröße := (SichtweitenGrafik.Kartenfeldfläche.x, DickeRahmen);
            Rahmenposition := PositionExtern;
         
         when KartenartDatentypen.Westen_Enum =>
            Rahmengröße := (DickeRahmen, SichtweitenGrafik.Kartenfeldfläche.y);
            Rahmenposition := PositionExtern;
         
         when KartenartDatentypen.Osten_Enum =>
            Rahmengröße := (DickeRahmen, SichtweitenGrafik.Kartenfeldfläche.y);
            Rahmenposition := (PositionExtern.x + SichtweitenGrafik.Kartenfeldfläche.x - DickeRahmen, PositionExtern.y);
         
         when KartenartDatentypen.Süden_Enum =>
            Rahmengröße := (SichtweitenGrafik.Kartenfeldfläche.x, DickeRahmen);
            Rahmenposition := (PositionExtern.x, PositionExtern.y + SichtweitenGrafik.Kartenfeldfläche.y - DickeRahmen);
      end case;
      
      ObjekteZeichnenGrafik.RahmenteilZeichnen (PositionExtern => Rahmenposition,
                                                FarbeExtern    => SpezieseinstellungenGrafik.SpeziesfarbenRahmen (SpeziesExtern),
                                                GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   -- Später noch einen Rahmen um den Namen bauen? äöü
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
            
      StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern);
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            Farbe := Sf.Graphics.Color.sfBlack;
            
         when others =>
            Farbe := Sf.Graphics.Color.sfWhite;
      end case;
      
      TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.KarteAccess,
                                                   TextExtern       => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummer)),
                                                   FarbeExtern      => Farbe);
      
      Textbreite := Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAccess).width;
      
      if
        Textbreite > 5.00 * SichtweitenGrafik.Kartenfeldfläche.x
      then
         Skalierung := (5.00 * SichtweitenGrafik.Kartenfeldfläche.x / Textbreite, 0.70);
         
      else
         Skalierung := (GrafikRecordKonstanten.Standardskalierung.x, 0.70);
      end if;
      
      TextaccessverwaltungssystemGrafik.Skalieren (TextaccessExtern => TextaccessVariablen.KarteAccess,
                                                   SkalierungExtern => Skalierung);
      
      Textposition.x := PositionExtern.x - TextberechnungenBreiteGrafik.HalbeBreiteBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.KarteAccess) + 0.50 * SichtweitenGrafik.Kartenfeldfläche.x;
      Textposition.y := PositionExtern.y - TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.KarteAccess,
                                                          PositionExtern   => Textposition);
      
   end StadtnameAnzeigen;
   
   
   
   -- Das später auch noch über die Ebenen hinweg sichtbar machen? äöü
   procedure AnzeigeFeldeffekt
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is begin
      
      EffekteSchleife:
      for EffektSchleifenwert in KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range loop
         
         case
           LeseWeltkarte.Effekt (KoordinatenExtern   => KoordinatenExtern,
                                 WelcherEffektExtern => EffektSchleifenwert)
         is
            when True =>
               KartenspritesZeichnenGrafik.KartenfeldZeichnen (TexturAccessExtern     => EingeleseneTexturenGrafik.FeldeffekteAccess (EffektSchleifenwert),
                                                               PositionExtern         => PositionExtern,
                                                               DurchsichtigkeitExtern => GrafikKonstanten.Feldeffekttransparents);
               
            when False =>
               null;
         end case;
         
      end loop EffekteSchleife;
      
   end AnzeigeFeldeffekt;

end WeltkartZusatzZeichnenGrafik;
