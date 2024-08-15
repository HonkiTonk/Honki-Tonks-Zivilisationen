with KartenartDatentypen;

package body KIXAchsenbewertung is

   function XAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        NeuerPunktExtern = ZielpunktExtern
      then
         return 0;
         
      else
         Felderanzahl (1) := abs (ZielpunktExtern - NeuerPunktExtern);
      end if;
      
      case
        LeseWeltkarteneinstellungen.XAchseWesten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.WaagerechtePositiv'Last;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := StandardübergangWesten (ZielpunktExtern  => ZielpunktExtern,
                                                         NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.WaagerechtePositiv'Last;
      end case;
      
      case
        LeseWeltkarteneinstellungen.XAchseOsten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            Felderanzahl (3) := KartenDatentypen.WaagerechtePositiv'Last;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            Felderanzahl (3) := StandardübergangOsten (ZielpunktExtern  => ZielpunktExtern,
                                                        NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            Felderanzahl (3) := KartenDatentypen.WaagerechtePositiv'Last;
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
      
   end XAchseBewerten;
   
   
   
   function StandardübergangWesten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        NeuerPunktExtern < ZielpunktExtern
      then
         return NeuerPunktExtern - ZielpunktExtern + LeseWeltkarteneinstellungen.XAchse;
                  
      else
         return KartenDatentypen.WaagerechtePositiv'Last;
      end if;
      
   end StandardübergangWesten;
   
   
   
   function StandardübergangOsten
     (ZielpunktExtern : in KartenDatentypen.WaagerechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.WaagerechtePositiv)
      return KartenDatentypen.WaagerechteNatural
   is begin
      
      if
        ZielpunktExtern < NeuerPunktExtern
      then
         return ZielpunktExtern - NeuerPunktExtern + LeseWeltkarteneinstellungen.XAchse;
         
      else
         return KartenDatentypen.WaagerechtePositiv'Last;
      end if;
      
   end StandardübergangOsten;

end KIXAchsenbewertung;
