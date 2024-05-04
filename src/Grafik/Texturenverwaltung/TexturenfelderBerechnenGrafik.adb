with Sf.Graphics.Texture;

with EingeleseneTexturenGrafik;

with Diagnoseinformationen;

package body TexturenfelderBerechnenGrafik is

   procedure TexturenfelderBerechnen
   is begin
      
      BasisgrundBerechnen;
      
   end TexturenfelderBerechnen;
   
   
   
   procedure BasisgrundBerechnen
   is
      use type Sf.sfUint32;
   begin
            
      Texturenauflösung := Sf.Graphics.Texture.getSize (texture => EingeleseneTexturenGrafik.BasisgrundGesamt);
      
      Feldauflösung := (Texturenauflösung.x / FeldanzahlBasisgrund.x, Texturenauflösung.y / FeldanzahlBasisgrund.y);
      
      AktuelleFeldposition := (1, 1);
      
      BasisgrundSchleife:
      for BasisgrundSchleifenwert in BasisgrundArray'Range loop
         
         Basisgrund (BasisgrundSchleifenwert) := (Integer (AktuelleFeldposition.x * Feldauflösung.x - Feldauflösung.x),
                                                  Integer (AktuelleFeldposition.y * Feldauflösung.y - Feldauflösung.y),
                                                  Integer (AktuelleFeldposition.x * Feldauflösung.x),
                                                  Integer (AktuelleFeldposition.y * Feldauflösung.y));
         
         Diagnoseinformationen.Boxinformationen (BoxExtern => Basisgrund (BasisgrundSchleifenwert));
         
         if
           AktuelleFeldposition.x < FeldanzahlBasisgrund.x
         then
            AktuelleFeldposition.x := AktuelleFeldposition.x + 1;
            
         else
            AktuelleFeldposition.x := 1;
            AktuelleFeldposition.y := AktuelleFeldposition.y + 1;
         end if;
         
      end loop BasisgrundSchleife;
      
   end BasisgrundBerechnen;
   
   
   
   function BasisgrundFelderwerte
     (BasisgrundExtern : in KartengrundDatentypen.Basisgrund_Vorhanden_Enum)
      return Sf.Graphics.Rect.sfIntRect
   is begin
      
      return Basisgrund (BasisgrundExtern);
      
   end BasisgrundFelderwerte;

end TexturenfelderBerechnenGrafik;
