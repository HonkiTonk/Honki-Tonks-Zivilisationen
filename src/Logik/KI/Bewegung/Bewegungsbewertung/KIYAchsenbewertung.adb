with KartenartDatentypen;

package body KIYAchsenbewertung is

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        NeuerPunktExtern = ZielpunktExtern
      then
         return 0;
         
      else
         Felderanzahl (1) := abs (ZielpunktExtern - NeuerPunktExtern);
      end if;
      
      case
        LeseWeltkarteneinstellungen.YAchseNorden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := StandardübergangNorden (ZielpunktExtern  => ZielpunktExtern,
                                                         NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.SenkrechtePositiv'Last;
      end case;
      
      case
        LeseWeltkarteneinstellungen.YAchseSüden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Felderanzahl (3) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Felderanzahl (3) := StandardübergangSüden (ZielpunktExtern  => ZielpunktExtern,
                                                         NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Felderanzahl (3) := KartenDatentypen.SenkrechtePositiv'Last;
      end case;
      
      WelcheFelderanzahl := 1;
      
      BewertenSchleife:
      for BewertenSchleifenwert in FelderanzahlArray'Range loop
         
         if
           Felderanzahl (BewertenSchleifenwert) < Felderanzahl (WelcheFelderanzahl)
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         else
            null;
         end if;
                    
      end loop BewertenSchleife;
      
      return Felderanzahl (WelcheFelderanzahl);
      
   end YAchseBewerten;
   
   
   
   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        NeuerPunktExtern < ZielpunktExtern
      then
         return NeuerPunktExtern - ZielpunktExtern + LeseWeltkarteneinstellungen.YAchse;
                  
      else
         return KartenDatentypen.SenkrechtePositiv'Last;
      end if;
      
   end StandardübergangNorden;
   
   
   
   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        ZielpunktExtern < NeuerPunktExtern
      then
         return ZielpunktExtern - NeuerPunktExtern + LeseWeltkarteneinstellungen.YAchse;
         
      else
         return KartenDatentypen.SenkrechtePositiv'Last;
      end if;
      
   end StandardübergangSüden;

end KIYAchsenbewertung;
