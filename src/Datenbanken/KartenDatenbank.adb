package body KartenDatenbank is

   procedure Beschreibung (ID : in GlobaleDatentypen.KartenGrund) is
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
                                ErsteZeile         => Integer (ID) + 1,
                                LetzteZeile        => Integer (ID) + 1);
            Put (Item => "    ");
      end case;
      
   end Beschreibung;

end KartenDatenbank;
