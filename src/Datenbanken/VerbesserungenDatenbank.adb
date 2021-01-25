package body VerbesserungenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenVerbesserung) is
   begin
      
      case ID is
         when 0 =>
            null;
            
         when others =>
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 0,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 6,
                                ErsteZeile         => Integer (ID) + 54,
                                LetzteZeile        => Integer (ID) + 54);
            Put (Item => "    ");
      end case;
      
   end Beschreibung;

end VerbesserungenDatenbank;
