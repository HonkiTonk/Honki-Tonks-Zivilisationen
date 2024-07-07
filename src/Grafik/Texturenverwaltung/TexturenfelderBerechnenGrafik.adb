with Sf.Graphics.Texture;

with EingeleseneTexturenGrafik;
with TexturenfelderVariablenGrafik;

-- Das noch mal in Bereiche aufteilen?
package body TexturenfelderBerechnenGrafik is

   procedure TexturenfelderBerechnen
   is begin
      
      BasisgrundBerechnen;
      ZusatzgrundBerechnen;
      FlüsseBerechnen;
      RessourcenBerechnen;
      VerbesserungenBerechnen;
      WegeBerechnen;
      FeldeffekteBerechnen;
      
      Speziesberechnungen;
      
      IntroBerechnen;
      AllgemeinesBerechnen;
      Kartenbefehle;
      Einheitenbefehle;
      Kartenformen;
      
   end TexturenfelderBerechnen;
   
   
   
   procedure BasisgrundBerechnen
   is
      use type Sf.sfUint32;
   begin
            
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BasisgrundAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlBasisgrund.x, Texturengröße.y / FelderanzahlBasisgrund.y);
      
      AktuelleFeldposition := (1, 1);
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in TexturenfelderVariablenGrafik.BasisgrundArray'Range loop
         
         TexturenfelderVariablenGrafik.Basisgrund (BasisgrundSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                Integer (Feldgröße.x),
                                                                                Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlBasisgrund.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop BasisgrundSchleife;
      
   end BasisgrundBerechnen;
   
   
   
   procedure ZusatzgrundBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.ZusatzgrundAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlZusatzgrund.x, Texturengröße.y / FelderanzahlZusatzgrund.y);
      
      AktuelleFeldposition := (1, 1);
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in TexturenfelderVariablenGrafik.ZusatzgrundArray'Range loop
         
         TexturenfelderVariablenGrafik.Zusatzgrund (ZusatzgrundSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                  Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                  Integer (Feldgröße.x),
                                                                                  Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlZusatzgrund.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop ZusatzgrundSchleife;
      
   end ZusatzgrundBerechnen;
   
   
   
   procedure FlüsseBerechnen
   is
      use type Sf.sfUint32;
   begin
            
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.FlussAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlFlüsse.x, Texturengröße.y / FelderanzahlFlüsse.y);
      
      AktuelleFeldposition := (1, 1);
            
      FlüsseSchleife:
      for FlüsseSchleifenwert in TexturenfelderVariablenGrafik.FlüsseArray'Range loop
         
         TexturenfelderVariablenGrafik.Flüsse (FlüsseSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                          Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                          Integer (Feldgröße.x),
                                                                          Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlFlüsse.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop FlüsseSchleife;
      
   end FlüsseBerechnen;
   
   
      
   procedure RessourcenBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.RessourcenAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlRessourcen.x, Texturengröße.y / FelderanzahlRessourcen.y);
      
      AktuelleFeldposition := (1, 1);
      
      RessourcenSchleife:
      for RessourcenSchleifenwert in TexturenfelderVariablenGrafik.RessourcenArray'Range loop
         
         TexturenfelderVariablenGrafik.Ressourcen (RessourcenSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                Integer (Feldgröße.x),
                                                                                Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlRessourcen.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop RessourcenSchleife;
      
   end RessourcenBerechnen;
   
   
   
   procedure VerbesserungenBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.VerbesserungenAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlVerbesserungen.x, Texturengröße.y / FelderanzahlVerbesserungen.y);
      
      AktuelleFeldposition := (1, 1);
      
      VerbesserungenSchleife:
      for VerbesserungenSchleifenwert in TexturenfelderVariablenGrafik.VerbesserungenArray'Range loop
         
         TexturenfelderVariablenGrafik.Verbesserungen (VerbesserungenSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                        Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                        Integer (Feldgröße.x),
                                                                                        Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlVerbesserungen.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop VerbesserungenSchleife;
      
   end VerbesserungenBerechnen;
   
   
   
   procedure WegeBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.WegeAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlWege.x, Texturengröße.y / FelderanzahlWege.y);
      
      AktuelleFeldposition := (1, 1);
      
      WegeSchleife:
      for WegeSchleifenwert in TexturenfelderVariablenGrafik.Wege'Range loop
         
         TexturenfelderVariablenGrafik.Wege (WegeSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                    Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                    Integer (Feldgröße.x),
                                                                    Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlWege.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop WegeSchleife;
      
   end WegeBerechnen;
   
   
   
   procedure FeldeffekteBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.FeldeffekteAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlFeldeffekte.x, Texturengröße.y / FelderanzahlFeldeffekte.y);
      
      AktuelleFeldposition := (1, 1);
      
      FeldeffekteSchleife:
      for FeldeffekteSchleifenwert in TexturenfelderVariablenGrafik.FeldeffekteArray'Range loop
         
         TexturenfelderVariablenGrafik.Feldeffekte (FeldeffekteSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                  Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                  Integer (Feldgröße.x),
                                                                                  Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlFeldeffekte.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop FeldeffekteSchleife;
      
   end FeldeffekteBerechnen;
   
   
   
   procedure Speziesberechnungen
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
      
         HintergründeBerechnen (SpeziesExtern => SpeziesSchleifenwert);
         EinheitenBerechnen (SpeziesExtern => SpeziesSchleifenwert);
         GebäudeBerechnen (SpeziesExtern => SpeziesSchleifenwert);
         
      end loop SpeziesSchleife;
      
   end Speziesberechnungen;
   
   
   
   procedure HintergründeBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.HintergrundAccessGesamt (SpeziesExtern));
      
      Feldgröße := (Texturengröße.x / FelderanzahlHintergründe.x, Texturengröße.y / FelderanzahlHintergründe.y);
      
      AktuelleFeldposition := (1, 1);
      
      HintergründeSchleife:
      for HintergründeSchleifenwert in TexturenfelderVariablenGrafik.HintergründeArray'Range (2) loop
         
         TexturenfelderVariablenGrafik.Hintergründe (SpeziesExtern, HintergründeSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                                     Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                                     Integer (Feldgröße.x),
                                                                                                     Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlHintergründe.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
            
      end loop HintergründeSchleife;
      
   end HintergründeBerechnen;
   
   
   
   procedure EinheitenBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.EinheitenAccess (SpeziesExtern));
      
      Feldgröße := (Texturengröße.x / FelderanzahlEinheiten.x, Texturengröße.y / FelderanzahlEinheiten.y);
      
      AktuelleFeldposition := (1, 1);
      
      EinheitenSchleife:
      for EinheitenSchleifenwert in TexturenfelderVariablenGrafik.EinheitenArray'Range (2) loop
         
         TexturenfelderVariablenGrafik.Einheiten (SpeziesExtern, EinheitenSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                             Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                             Integer (Feldgröße.x),
                                                                                             Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlEinheiten.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
            
      end loop EinheitenSchleife;
      
   end EinheitenBerechnen;
   
   
   
   procedure GebäudeBerechnen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.GebäudeAccess (SpeziesExtern));
      
      Feldgröße := (Texturengröße.x / FelderanzahlGebäude.x, Texturengröße.y / FelderanzahlGebäude.y);
      
      AktuelleFeldposition := (1, 1);
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in TexturenfelderVariablenGrafik.GebäudeArray'Range (2) loop
         
         TexturenfelderVariablenGrafik.Gebäude (SpeziesExtern, GebäudeSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                           Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                           Integer (Feldgröße.x),
                                                                                           Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlGebäude.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop GebäudeSchleife;
      
   end GebäudeBerechnen;
   
   
   
   procedure IntroBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.IntroAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlIntro.x, Texturengröße.y / FelderanzahlIntro.y);
      
      AktuelleFeldposition := (1, 1);
      
      IntroSchleife:
      for IntroSchleifenwert in TexturenfelderVariablenGrafik.IntroArray'Range loop
         
         TexturenfelderVariablenGrafik.Intro (IntroSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                      Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                      Integer (Feldgröße.x),
                                                                      Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlIntro.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop IntroSchleife;
      
   end IntroBerechnen;
   
   
   
   procedure AllgemeinesBerechnen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.AllgemeinesAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlAllgemeines.x, Texturengröße.y / FelderanzahlAllgemeines.y);
      
      AktuelleFeldposition := (1, 1);
      
      AllgemeinesSchleife:
      for AllgemeinesSchleifenwert in TexturenfelderVariablenGrafik.AllgemeinesArray'Range loop
         
         TexturenfelderVariablenGrafik.Allgemeines (AllgemeinesSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                  Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                  Integer (Feldgröße.x),
                                                                                  Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlAllgemeines.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop AllgemeinesSchleife;
      
   end AllgemeinesBerechnen;
   
   
   
   procedure Kartenbefehle
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenbefehleAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlKartenbefehle.x, Texturengröße.y / FelderanzahlKartenbefehle.y);
      
      AktuelleFeldposition := (1, 1);
      
      KartenbefehleSchleife:
      for KartenbefehleSchleifenwert in TexturenfelderVariablenGrafik.KartenbefehleArray'Range loop
         
         TexturenfelderVariablenGrafik.Kartenbefehle (KartenbefehleSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                      Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                      Integer (Feldgröße.x),
                                                                                      Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlKartenbefehle.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop KartenbefehleSchleife;
      
   end Kartenbefehle;
   
   
   
   procedure Einheitenbefehle
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenbefehleAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlEinheitenbefehle.x, Texturengröße.y / FelderanzahlEinheitenbefehle.y);
      
      AktuelleFeldposition := (1, 1);
      
      EinheitenbefehleSchleife:
      for EinheitenbefehleSchleifenwert in TexturenfelderVariablenGrafik.EinheitenbefehleArray'Range loop
         
         TexturenfelderVariablenGrafik.Einheitenbefehle (EinheitenbefehleSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                            Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                            Integer (Feldgröße.x),
                                                                                            Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlEinheitenbefehle.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop EinheitenbefehleSchleife;
      
   end Einheitenbefehle;
   
   
   
   procedure Kartenformen
   is
      use type Sf.sfUint32;
   begin
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.KartenformenAccess);
      
      Feldgröße := (Texturengröße.x / FelderanzahlKartenformen.x, Texturengröße.y / FelderanzahlKartenformen.y);
      
      AktuelleFeldposition := (1, 1);
      
      KartenformenSchleife:
      for KartenformenSchleifenwert in TexturenfelderVariablenGrafik.KartenformenArray'Range loop
         
         TexturenfelderVariablenGrafik.Kartenformen (KartenformenSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
                                                                                    Integer (AktuelleFeldposition.y * Feldgröße.y - Feldgröße.y),
                                                                                    Integer (Feldgröße.x),
                                                                                    Integer (Feldgröße.y));
         
         if
           AktuelleFeldposition.x < FelderanzahlKartenformen.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop KartenformenSchleife;
      
   end Kartenformen;
     
end TexturenfelderBerechnenGrafik;
