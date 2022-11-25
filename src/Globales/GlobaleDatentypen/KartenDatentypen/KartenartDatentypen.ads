package KartenartDatentypen is
   pragma Pure;

   type Kartenart_Enum is (
                           -- Normal
                           Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum,
                           
                           -- Nutzerdefiniert
                           Kartenart_Nutzerdefiniert_Enum
                          );
   pragma Ordered (Kartenart_Enum);
   
   subtype Kartenart_Normal_Enum is Kartenart_Enum range Kartenart_Inseln_Enum .. Kartenart_Pangäa_Enum;
   
   
   
   type Kartenform_Enum is (
                            Karte_E_Kein_Übergang_Enum, Karte_E_Übergang_Enum,
                            Karte_Y_Kein_Übergang_Enum, Karte_Y_Übergang_Enum, Karte_Y_Rückwärts_Verschobener_Übergang_Enum, Karte_Y_Verschobener_Übergang_Enum,
                            Karte_X_Kein_Übergang_Enum, Karte_X_Übergang_Enum, Karte_X_Rückwärts_Verschobener_Übergang_Enum, Karte_X_Verschobener_Übergang_Enum
                           ); 
   pragma Ordered (Kartenform_Enum);
   
   subtype Kartenform_E_Einstellbar_Enum is Kartenform_Enum range Karte_E_Kein_Übergang_Enum .. Karte_E_Übergang_Enum;
   subtype Kartenform_Y_Einstellbar_Enum is Kartenform_Enum range Karte_Y_Kein_Übergang_Enum .. Karte_Y_Verschobener_Übergang_Enum;
   subtype Kartenform_X_Einstellbar_Enum is Kartenform_Enum range Karte_X_Kein_Übergang_Enum .. Karte_X_Verschobener_Übergang_Enum;
   
   
   
   -- Statt eines Enums einen Zahlenwert von 0 bis 100 einbauen? äöü
   type Kartentemperatur_Enum is (
                                  Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum
                                 );
   pragma Ordered (Kartentemperatur_Enum);
   
   
   
   -- Das hier durch einen Zahlenwert von 0 bis 100 ersetzen? äöü
   -- Und später noch eine Möglichkeit einbauen um jeden Wert einzeln festzulegen? äöü
   type Kartenressourcenmenge_Enum is (
                                       Kartenressourcen_Arm_Enum, Kartenressourcen_Wenig_Enum, Kartenressourcen_Mittel_Enum, Kartenressourcen_Viel_Enum, Kartenressourcen_Überfluss_Enum
                                      );
   pragma Ordered (Kartenressourcenmenge_Enum);
   
   
   
   type Himmelsrichtungen_Enum is (
                                   Norden_Enum, Süden_Enum, Westen_Enum, Osten_Enum
                                  );
   
   
   
   type Kartenpole_Enum is (
                            Kartenpol_Nicht_Vorhanden_Enum, Kartenpol_Vorhanden_Enum
                           );
   pragma Ordered (Kartenpole_Enum);

end KartenartDatentypen;
