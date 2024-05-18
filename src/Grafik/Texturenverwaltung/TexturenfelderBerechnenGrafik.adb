with Sf.Graphics.Texture;

with EingeleseneTexturenGrafik;

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
      EinheitenBerechnen;
      GebäudeBerechnen;
      
   end TexturenfelderBerechnen;
   
   
   
   procedure BasisgrundBerechnen
   is
      use type Sf.sfUint32;
   begin
            
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BasisgrundAccessGesamt);
      
      Feldgröße := (Texturengröße.x / FelderanzahlBasisgrund.x, Texturengröße.y / FelderanzahlBasisgrund.y);
      
      AktuelleFeldposition := (1, 1);
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in BasisgrundArray'Range loop
         
         Basisgrund (BasisgrundSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
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
      
      Texturengröße := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.ZusatzgrundAccessGesamt);
      
      Feldgröße := (Texturengröße.x / FelderanzahlBasisgrund.x, Texturengröße.y / FelderanzahlBasisgrund.y);
      
      AktuelleFeldposition := (1, 1);
      
      ZusatzgrundSchleife:
      for ZusatzgrundSchleifenwert in ZusatzgrundArray'Range loop
         
         Zusatzgrund (ZusatzgrundSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldgröße.x - Feldgröße.x),
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
   is begin
      
      null;
      
   end FlüsseBerechnen;
   
   
      
   procedure RessourcenBerechnen
   is begin
      
      null;
      
   end RessourcenBerechnen;
   
   
   
   procedure VerbesserungenBerechnen
   is begin
      
      null;
      
   end VerbesserungenBerechnen;
   
   
   
   procedure WegeBerechnen
   is begin
      
      null;
      
   end WegeBerechnen;
   
   
   
   procedure FeldeffekteBerechnen
   is begin
      
      null;
      
   end FeldeffekteBerechnen;
   
   
   
   procedure EinheitenBerechnen
   is begin
      
      null;
      
   end EinheitenBerechnen;
   
   
   
   procedure GebäudeBerechnen
   is begin
      
      null;
      
   end GebäudeBerechnen;
      
      
      
   function Basisgrundbereich
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Basisgrund (BasisgrundExtern);
      
   end Basisgrundbereich;
   
   
   
   function Basisgrundabmessung
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      return (Float (Basisgrund (BasisgrundExtern).width), Float (Basisgrund (BasisgrundExtern).height));
      
   end Basisgrundabmessung;

end TexturenfelderBerechnenGrafik;
