with StadtKonstanten;
with StadtRecordKonstanten;
with GebaeudedatenbankRecord;
with ProduktionDatentypen;
with KampfKonstanten;

package GebaeudeCarupex is
   pragma Elaborate_Body;

   GebäudelisteCarupex : constant GebaeudedatenbankRecord.GebäudelisteArray := (
                                                                                  -- Häuser
                                                                                  1 =>
                                                                                    (
                                                                                     PreisGeld            => 100,
                                                                                     Produktionskosten    => 101,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 0,
                                                                                     Produktionsbonus     => (ProduktionDatentypen.Nahrung_Enum => 10,
                                                                                                              others                            => 0),
                                                                                     Kampfbonus           => (others => 10.00),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Nahrungslager
                                                                                  2 =>
                                                                                    (
                                                                                     PreisGeld            => 100,
                                                                                     Produktionskosten    => 102,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 2,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Holzpalisade
                                                                                  3 =>
                                                                                    (
                                                                                     PreisGeld            => 150,
                                                                                     Produktionskosten    => 103,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 1,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Schmiede
                                                                                  4 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 104,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 10,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
      
                                                                                    -- Bibliothek
                                                                                  5 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 105,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 9,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Steinmauer
                                                                                  6 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 106,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 11,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Bücherei
                                                                                  7 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 107,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 21,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Bewässerungssystem
                                                                                  8 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 108,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 16,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Kaserne
                                                                                  9 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 109,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 13,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Wassermühle
                                                                                  10 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 110,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 15,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Windmühle
                                                                                  11 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 111,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 15,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Seehafen
                                                                                  12 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 112,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 14,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Hochofen
                                                                                  13 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 113,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 33,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Universität
                                                                                  14 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 114,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 27,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Burg
                                                                                  15 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 115,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 22,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Schwere Burg
                                                                                  16 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 116,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 25,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Festungen
                                                                                  17 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 117,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 34,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Kohlekraftwerk
                                                                                  18 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 118,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 37,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Fabrik
                                                                                  19 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 119,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 30,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Krankenhaus
                                                                                  20 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 120,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 43,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Flughafen
                                                                                  21 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 121,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 41,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Atomkraftwerk
                                                                                  22 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 122,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 45,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Regenerative Kraftwerke (aufteilen oder zusammenlassen?)
                                                                                  23 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 123,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 53,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Genklinik
                                                                                  24 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 124,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 56,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- Fusionskraftwerk
                                                                                  25 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 125,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 60,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                             
                                                                                    -- NAMR Kraftwerk
                                                                                  26 =>
                                                                                    (
                                                                                     PreisGeld            => 1000,
                                                                                     Produktionskosten    => 126,
                                                                                     PermanenteKosten     => (others => 0),
                                                                                     Anforderungen        => 63,
                                                                                     Produktionsbonus     => (others => 0),
                                                                                     Kampfbonus           => (others => KampfKonstanten.LeerBonus),
                                                                                     BasisgrundBenötigt   => (others => StadtKonstanten.LeerBasisgrundBenötigt),
                                                                                     ZusatzgrundBenötigt  => (others => StadtKonstanten.LeerZusatzgrundBenötigt),
                                                                                     FlussBenötigt        => (others => StadtKonstanten.LeerFlussBenötigt),
                                                                                     RessourceBenötigt    => (others => StadtKonstanten.LeerRessourceBenötigt),
                                                                                     VerbesserungBenötigt => (others => StadtKonstanten.LeerVerbesserungBenötigt),
                                                                                     WegBenötigt          => (others => StadtKonstanten.LeerWegBenötigt),
                                                                                     GebäudeBenötigt      => (others => StadtKonstanten.LeerGebäudeBenötigt),
                                                                                     EbeneBenötigt        => (others => StadtKonstanten.LeerEbeneBenötigt),
                                                                                     SpezielleEigenschaft => StadtKonstanten.LeerSpezielleEigenschaft
                                                                                    ),
                                                              
                                                                                  others => StadtRecordKonstanten.LeerGebäudeListe
                                                                                 );

end GebaeudeCarupex;
