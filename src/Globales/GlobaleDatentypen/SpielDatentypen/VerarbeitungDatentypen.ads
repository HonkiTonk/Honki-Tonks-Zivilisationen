package VerarbeitungDatentypen is
   pragma Pure;
   
   -- Dinge wie Handelsgüter auch in mehrere Kategorien erlauben? Erscheint bei einige Gütern sinnvoll. äöü
   -- Später einsortieren/weiter unterteilen: äöü
   -- Munition
   -- Bögen, Armbrüste, Waffen
   -- Plastik
   type Verarbeitungsstufe_Eins_Enum is (
                                         Leer_Verarbeitung_Enum,
                                   
                                         Zucker_Enum, Papier_Enum, Glas_Enum, Werkzeuge_Enum, Wein_Enum, Porzellan_Enum, Leder_Enum, Möbel_Enum, Luxusgüter_Enum, Schmuck_Enum,
                                         Arzneimittel_Enum, Waffen_Enum, Schusswaffen_Enum, Artillerie_Enum, Gummi_Enum, Farbstoffe_Enum, Wolle_Enum, Kakao_Enum, Pfeffer_Enum, Bier_Enum, Pelze_Enum, Kaffee_Enum,
                                         Seide_Enum, Holzkohle_Enum, Salz_Enum, Gold_Enum, Silber_Enum, Eisen_Enum, Kupfer_Enum, Benzin_Enum, Uran_Enum, Öl_Enum, Mangan_Enum, Aluminium_Enum, Elfenbein_Enum,
                                         Honig_Enum, Opium_Enum, Inhalationsprodukte_Enum, Keramik_Enum, Milch_Enum, Olivenöl_Enum, Spirituosen_Enum, Teer_Enum, Wachs_Enum, Seltene_Pelze_Enum, Seltenes_Leder_Enum,
                                         Schießpulver_Enum, Bauholz_Enum, Ahornsirup_Enum, Palmöl_Enum, Rum_Enum, Ziegel_Enum, Mehl_Enum, Most_Enum, Messing_Enum, Fässer_Enum, Walfett_Enum, Lampenöl_Enum,
                                         Nahrung_Enum, Kaviar_Enum, Chitin_Enum, Tee_Enum, Zinn_Enum, Kobalt_Enum, Blei_Enum, Quecksilber_Enum, Schieferöl_Enum, Chinin_Enum, Handelsgüter_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Eins_Enum);
   
   subtype Verarbeitungsstufe_Eins_Vorhanden_Enum is Verarbeitungsstufe_Eins_Enum range Verarbeitungsstufe_Eins_Enum'Succ (Verarbeitungsstufe_Eins_Enum'First) .. Verarbeitungsstufe_Eins_Enum'Last;
   
   
   
   type Verarbeitungsstufe_Zwei_Enum is (
                                         Leer_Verarbeitung_Enum,
                                         
                                         Stoff_Enum, Bücher_Enum, Werkzeug_Maschinen_Enum, Käse_Enum, Teppiche_Enum, Tuch_Enum, Eis_Enum, Brot_Enum, Seile_Enum, Kerzen_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Zwei_Enum);
   
   subtype Verarbeitungsstufe_Zwei_Vorhanden_Enum is Verarbeitungsstufe_Zwei_Enum range Verarbeitungsstufe_Zwei_Enum'Succ (Verarbeitungsstufe_Zwei_Enum'First) .. Verarbeitungsstufe_Zwei_Enum'Last;
   
   
   
   type Verarbeitungsstufe_Drei_Enum is (
                                         Leer_Verarbeitung_Enum,
                                         
                                         Kleidung_Enum, CnC_Maschinen_Enum
                                        );
   pragma Ordered (Verarbeitungsstufe_Drei_Enum);
   
   subtype Verarbeitungsstufe_Drei_Vorhanden_Enum is Verarbeitungsstufe_Drei_Enum range Verarbeitungsstufe_Drei_Enum'Succ (Verarbeitungsstufe_Drei_Enum'First) .. Verarbeitungsstufe_Drei_Enum'Last;

end VerarbeitungDatentypen;
