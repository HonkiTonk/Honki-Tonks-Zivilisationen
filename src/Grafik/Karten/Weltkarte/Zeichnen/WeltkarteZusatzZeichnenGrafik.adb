with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with SpeziesKonstanten;
with KartenKonstanten;
with TextaccessVariablen;
with GrafikKonstanten;
with KartengrundDatentypen;
with GrafikDatentypen;

with LeseWeltkarte;
with LeseStadtGebaut;

with TextberechnungenBreiteGrafik;
with SpezieseinstellungenGrafik;
with KartenkoordinatenberechnungssystemLogik;
with TextaccessverwaltungssystemGrafik;
with StadtSuchenLogik;
with KartenspritesZeichnenGrafik;
with EingeleseneTexturenGrafik;
with ObjekteZeichnenGrafik;
with SichtweitenGrafik;
with TextskalierungGrafik;
with HintergrundGrafik;

package body WeltkarteZusatzZeichnenGrafik is

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
            
         when KartenverbesserungDatentypen.Verbesserung_Städte_Enum =>
            if
              KoordinatenExtern.EAchse = EbeneExtern
            then
               StadtnameAnzeigen (KoordinatenExtern => KoordinatenExtern,
                                  PositionExtern    => PositionExtern,
                                  ObenUntenExtern   => True);
               
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
                                                FarbeExtern    => SpezieseinstellungenGrafik.SpeziesfarbeLesen (SpeziesExtern => SpeziesExtern),
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
                                                FarbeExtern    => SpezieseinstellungenGrafik.RahmenfarbeLesen (SpeziesExtern => SpeziesExtern),
                                                GrößeExtern    => Rahmengröße);
      
   end RahmenZeichnen;
   
   
   
   procedure StadtnameAnzeigen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      ObenUntenExtern : in Boolean)
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      if
        KoordinatenExtern.YAchse = KartenDatentypen.KartenfeldPositiv'First
        and
          ObenUntenExtern
          and
            LeseWeltkarteneinstellungen.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         return;
         
      else
         StadtSpeziesNummer := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern);
      
         Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.KarteAccess,
                                            -- Der Zugriff auf LeseStadtGebaut kann hier nur schwer vermieden werden im aktuellen System. äöü
                                            -- Erst einmal drin lassen und eventuell bei späteren Änderungen am System dann auch hier anpassen. äöü
                                            str  => To_Wide_Wide_String (Source => LeseStadtGebaut.Name (StadtSpeziesNummerExtern => StadtSpeziesNummer)));
      
         Textgröße := (Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAccess).width, Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.KarteAccess).height);
         Skalierung.x := TextskalierungGrafik.Breitenskalierung (AktuelleBreiteExtern => Textgröße.x,
                                                                 -- Die erlaubte Breite unabhängig/unabhängiger von der Kartfenfeldgröße gestalten. äöü
                                                                 ErlaubteBreiteExtern => 5.00 * SichtweitenGrafik.Kartenfeldfläche.x);
         Skalierung.y := 0.70;
      
         TextaccessverwaltungssystemGrafik.Skalieren (TextaccessExtern => TextaccessVariablen.KarteAccess,
                                                      SkalierungExtern => Skalierung);
      
         Textposition.x := PositionExtern.x
           - TextberechnungenBreiteGrafik.HalbeBreiteBerechnenGlobaleGrenzen (TextAccessExtern => TextaccessVariablen.KarteAccess) + SichtweitenGrafik.Kartenfeldfläche.x / GrafikKonstanten.Halbierung;
      end if;
      
      if
        Textposition.x < GrafikKonstanten.Nullwert
      then
         Textposition.x := GrafikKonstanten.Nullwert;
         
      elsif
        Textposition.x > SichtweitenGrafik.Kartenfläche.x - Textgröße.x * Skalierung.x
      then
         Textposition.x := SichtweitenGrafik.Kartenfläche.x - Textgröße.x * Skalierung.x;
         
      else
         null;
      end if;
            
      case
        ObenUntenExtern
      is
         when True =>
            Textposition.y := PositionExtern.y - Textgröße.y;
            
         when False =>
            Textposition.y := PositionExtern.y;
      end case;
      
      HintergrundGrafik.HintergrundPositionierbar (HintergrundExtern      => GrafikDatentypen.Auswahl_Hintergrund_Enum,
                                                   AbmessungenExtern      => (Textgröße.x * Skalierung.x * 1.02, Textgröße.y),
                                                   PositionExtern         => Textposition,
                                                   DurchsichtigkeitExtern => GrafikKonstanten.Bewegungsfeldtransparents);
      
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

end WeltkarteZusatzZeichnenGrafik;
