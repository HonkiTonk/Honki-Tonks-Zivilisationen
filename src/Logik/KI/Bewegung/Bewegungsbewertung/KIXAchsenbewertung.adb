with KartenartDatentypen;

with LeseWeltkarteneinstellungen;

package body KIXAchsenbewertung is

   function XAchseBewerten
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
        LeseWeltkarteneinstellungen.XAchseWesten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            Felder (2) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            Felder (2) := StandardübergangWesten (ZielpunktExtern      => ZielpunktExtern,
                                                   AktuellerPunktExtern => AktuellerPunktExtern,
                                                   NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
            Felder (2) := KartenDatentypen.KartenfeldPositiv'Last;
      end case;
      
      case
        LeseWeltkarteneinstellungen.XAchseOsten
      is
         when KartenartDatentypen.Karte_X_Kein_Übergang_Enum =>
            Felder (3) := KartenDatentypen.KartenfeldPositiv'Last;
            
         when KartenartDatentypen.Karte_X_Übergang_Enum | KartenartDatentypen.Karte_X_Verschobener_Übergang_Enum =>
            Felder (3) := StandardübergangOsten (ZielpunktExtern      => ZielpunktExtern,
                                                  AktuellerPunktExtern => AktuellerPunktExtern,
                                                  NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_X_Rückwärts_Verschobener_Übergang_Enum =>
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
      
   end XAchseBewerten;
   
   
   
   function StandardübergangWesten
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
         return NeuerPunktExtern - ZielpunktExtern + LeseWeltkarteneinstellungen.XAchse;
                  
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangWesten;
   
   
   
   function StandardübergangOsten
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
         return ZielpunktExtern - NeuerPunktExtern + LeseWeltkarteneinstellungen.XAchse;
         
      else
         return KartenDatentypen.KartenfeldPositiv'Last;
      end if;
      
   end StandardübergangOsten;

end KIXAchsenbewertung;
