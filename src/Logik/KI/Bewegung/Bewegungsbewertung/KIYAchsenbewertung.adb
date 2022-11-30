with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KIYAchsenbewertung is

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        NeuerPunktExtern = ZielpunktExtern
      then
         return 0;
         
      else
         AnzahlFelder := abs (ZielpunktExtern - AktuellerPunktExtern);
         Felder (1) := abs (ZielpunktExtern - NeuerPunktExtern);
      end if;
      
      case
        LeseWeltkarteneinstellungen.YAchseNorden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Felder (2) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Felder (2) := StandardübergangNorden (ZielpunktExtern      => ZielpunktExtern,
                                                   AktuellerPunktExtern => AktuellerPunktExtern,
                                                   NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Felder (2) := KartenDatentypen.KartenfeldPositiv'Last;
      end case;
      
      case
        LeseWeltkarteneinstellungen.YAchseSüden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Felder (3) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum | KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Felder (3) := StandardübergangSüden (ZielpunktExtern      => ZielpunktExtern,
                                                   AktuellerPunktExtern => AktuellerPunktExtern,
                                                   NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Felder (3) := KartenDatentypen.KartenfeldPositiv'Last;
      end case;
      
      WelcheFelderanzahl := 0;
      
      BewertenSchleife:
      for BewertenSchleifenwert in FelderArray'Range loop
         
         if
           Felder (BewertenSchleifenwert) < AnzahlFelder
           and
             WelcheFelderanzahl = 0
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         elsif
           WelcheFelderanzahl /= 0
           and then
           Felder (BewertenSchleifenwert) < Felder (WelcheFelderanzahl)
         then
            WelcheFelderanzahl := BewertenSchleifenwert;
            
         else
            null;
         end if;
                    
      end loop BewertenSchleife;
      
      case
        WelcheFelderanzahl
      is
         when 0 =>
            return AnzahlFelder;
            
         when others =>
            return Felder (WelcheFelderanzahl);
      end case;
      
   end YAchseBewerten;
   
   
   
   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        NeuerPunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < ZielpunktExtern
      then
         return NeuerPunktExtern - ZielpunktExtern + LeseWeltkarteneinstellungen.YAchse;
                  
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangNorden;
   
   
   
   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        ZielpunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < NeuerPunktExtern
      then
         return ZielpunktExtern - NeuerPunktExtern + LeseWeltkarteneinstellungen.YAchse;
         
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangSüden;

end KIYAchsenbewertung;
