with KartenartDatentypen;

package body KISenkrechtebewertung is

   function SenkrechteBewerten
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
        LeseWeltkarteneinstellungen.SenkrechteNorden
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum =>
            Felderanzahl (2) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Senkrechte_Übergang_Enum | KartenartDatentypen.Senkrechte_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := StandardübergangNorden (ZielpunktExtern  => ZielpunktExtern,
                                                         NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum =>
            Felderanzahl (2) := KartenDatentypen.SenkrechtePositiv'Last;
      end case;
      
      case
        LeseWeltkarteneinstellungen.SenkrechteSüden
      is
         when KartenartDatentypen.Senkrechte_Übergangslos_Enum =>
            Felderanzahl (3) := KartenDatentypen.SenkrechtePositiv'Last;
            
         when KartenartDatentypen.Senkrechte_Übergang_Enum | KartenartDatentypen.Senkrechte_Verschobener_Übergang_Enum =>
            Felderanzahl (3) := StandardübergangSüden (ZielpunktExtern  => ZielpunktExtern,
                                                         NeuerPunktExtern => NeuerPunktExtern);
            
         when KartenartDatentypen.Senkrechte_Rückwärts_Verschobener_Übergang_Enum =>
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
      
   end SenkrechteBewerten;
   
   
   
   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.SenkrechtePositiv;
      NeuerPunktExtern : in KartenDatentypen.SenkrechtePositiv)
      return KartenDatentypen.SenkrechteNatural
   is begin
      
      if
        NeuerPunktExtern < ZielpunktExtern
      then
         return NeuerPunktExtern - ZielpunktExtern + LeseWeltkarteneinstellungen.Senkrechte;
                  
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
         return ZielpunktExtern - NeuerPunktExtern + LeseWeltkarteneinstellungen.Senkrechte;
         
      else
         return KartenDatentypen.SenkrechtePositiv'Last;
      end if;
      
   end StandardübergangSüden;

end KISenkrechtebewertung;
