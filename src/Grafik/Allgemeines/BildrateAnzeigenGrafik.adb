with Projekteinstellungen;
with Diagnoseinformationen;

package body BildrateAnzeigenGrafik is
   
   procedure Bildrate
   is begin
      
      AktuelleBildrate := 1.00 / Float (Clock - LetzteZeit);
      LetzteZeit := Clock;
      
      SFMLAnzeige (BildrateExtern => AktuelleBildrate);
      
      case
        Projekteinstellungen.Debug.VolleInformation
      is
         when True =>
            Terminalanzeige (BildrateExtern => AktuelleBildrate);
            
         when False =>
            null;
      end case;
            
   end Bildrate;
   
   

   procedure Terminalanzeige
     (BildrateExtern : in Float)
   is begin
      
      Diagnoseinformationen.Kommazahl (ZahlExtern => BildrateExtern);
      
   end Terminalanzeige;
   
   
   
   procedure SFMLAnzeige
     (BildrateExtern : in Float)
   is begin
      
      null;
      
   end SFMLAnzeige;

end BildrateAnzeigenGrafik;
